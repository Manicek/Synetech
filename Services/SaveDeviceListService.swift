//
// SaveDeviceListService.swift
//
// Created by Patrik Hora


import Foundation


class SaveDeviceListService {
    
    func callAsFunction(_ devices: [Device]) {
        print("Saving devices to local storage")
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(devices) else {
            print("Error: Cannot encode devices")
            return
        }
        UserDefaults.standard.set(data, forKey: AppConstants.deviceListDefaultsKey)
    }
}
