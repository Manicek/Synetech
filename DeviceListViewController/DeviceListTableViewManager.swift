//
// DeviceListTableViewManager.swift
//
// Created by Patrik Hora


import UIKit


// MARK: - DeviceListTableViewManagerDelegate

protocol DeviceListTableViewManagerDelegate: AnyObject {
    
    func cellTapped(object: Device)
}


// MARK: - DeviceListTableViewManager

class DeviceListTableViewManager: NSObject {
    
    weak var delegate: DeviceListTableViewManagerDelegate?
    weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            tableView?.register(DeviceTableViewCell.self, forCellReuseIdentifier: DeviceTableViewCell.identifer)
            tableView?.estimatedRowHeight = 56
            tableView?.rowHeight = UITableView.automaticDimension
        }
    }
    var objects = [Device]() {
        didSet {
            tableView?.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource

extension DeviceListTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceTableViewCell.identifer) as? DeviceTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(objects[indexPath.row])
        return cell
    }
}


// MARK: - UITableViewDelegate


extension DeviceListTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellTapped(object: objects[indexPath.row])
    }
}
