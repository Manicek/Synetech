//
// DeviceListViewController.swift
//
// Created by Patrik Hora


import UIKit


class DeviceListViewController: UIViewController {

    // MARK: - Properties
    
    private let myView = DeviceListView()
    private let tableViewManager = DeviceListTableViewManager()
    
    
    // MARK: - Services
    
    private let downloadDeviceList = DownloadDeviceListService()
    private let getPreviousDeviceList = GetPreviousDeviceListService()
    private let saveDeviceList = SaveDeviceListService()
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = myView
        
        tableViewManager.tableView = myView.tableView
        tableViewManager.delegate = self
        
        myView.reloadButton.addTarget(self, action: #selector(loadDevices), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Notification allowed")
                    } else if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Notifications denied")
                    }
                    self.loadDevices()
                }
            } else {
                self.loadDevices()
            }
        })
    }
}


// MARK: - DeviceListTableViewManagerDelegate

extension DeviceListViewController: DeviceListTableViewManagerDelegate {
    
    func cellTapped(object: Device) {
        if object.isBatteryLow {
            let url = URL(string: "https://synetech.cz/en/contact")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Error: Cannot open url for low battery device")
            }
        } else {
            print("cell with normal or unknown battery state tapped, ignoring")
        }
    }
}


// MARK: - Private extension {

private extension DeviceListViewController {
    
    @objc
    func loadDevices() {
        DispatchQueue.main.async {
            self.myView.reloadButton.isEnabled = false
        }
        
        downloadDeviceList { [weak self] devices in
            DispatchQueue.main.async {
                self?.myView.reloadButton.isEnabled = true
                self?.tableViewManager.objects = devices ?? []
            }
            self?.compareDevicesAndNotifyUserIfNeeded(devices ?? [])
        }
    }
    
    func compareDevicesAndNotifyUserIfNeeded(_ newDevices: [Device]) {
        let previousDevices = getPreviousDeviceList()
        var devicesThatChanged = [Device]()
        newDevices.forEach { newDevice in
            if newDevice.isBatteryLow {
                if previousDevices.contains(where: { previousDevice in
                    previousDevice.serialNumber == newDevice.serialNumber && previousDevice.isBatteryNormal
                }) {
                    devicesThatChanged.append(newDevice)
                }
            }
        }
        saveDeviceList(newDevices)
        print("Battery state changed to LOW from NORMAL for \(devicesThatChanged.count) devices")
        devicesThatChanged.forEach { device in
            showNotificationAboutDevice(device)
        }
    }
    
    func showNotificationAboutDevice(_ device: Device) {
        let content = UNMutableNotificationContent()
        content.title = "Warning"
        content.subtitle = "Battery Low for device \(device.serialNumber)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Requesting notification for device \(device.serialNumber)")
            }
        }
    }
}
