//
// GetPreviousDeviceListService.swift
//
// Created by Patrik Hora


import Foundation


class GetPreviousDeviceListService {
    
    func callAsFunction() -> [Device] {
        print("Getting previous devices from local storage")
        if let devicesData = UserDefaults.standard.data(forKey: AppConstants.deviceListDefaultsKey) {
            let decoder = JSONDecoder()
            if let devices = try? decoder.decode([Device].self, from: devicesData) {
                return devices
            }
            print("Error: Cannot decode devices from saved data")
            return []
        }
        print("Error: Cannot cast saved devices, will return empty array")
        return []
    }
}
