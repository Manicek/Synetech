//
// Device.swift
//
// Created by Patrik Hora


import Foundation
import UIKit


// MARK: - BatteryState

enum BatteryState: String, Codable {
    case low = "LOW"
    case normal = "NORMAL"
    case unknown = "UNKNOWN"
}


// MARK: - DeviceType

enum DeviceType: String, Codable {
    
    case bu01 = "BU01"
    case by01 = "BY01"
    case ib01 = "IB01"
    case ru01 = "RU01"
    case su02 = "SU02"
    case ts02 = "TS02"
    case va01 = "VA01"
    case wr01 = "WR01"
    
    var image: UIImage {
        switch self {
        case .bu01: return Asset.bu01
        case .by01: return Asset.by01
        case .ib01: return Asset.ib01
        case .ru01: return Asset.ru01
        case .su02: return Asset.su02
        case .ts02: return Asset.ts02
        case .va01: return Asset.va01
        case .wr01: return Asset.wr01
        }
    }
}


// MARK: - Device

struct Device: Codable {
    
    static func fromDTO(_ dto: DeviceDTO) -> Device {
        Device(
            deviceType: DeviceType(rawValue: dto.deviceType) ?? .bu01,
            serialNumber: dto.serialNo,
            batteryState: BatteryState(rawValue: dto.batteryState ?? "UNKNOWN") ?? .unknown
        )
    }
    
    init(deviceType: DeviceType, serialNumber: String, batteryState: BatteryState) {
        self.deviceType = deviceType
        self.serialNumber = serialNumber
        self.batteryState = batteryState
    }
    
    let deviceType: DeviceType
    let serialNumber: String
    let batteryState: BatteryState

    var image: UIImage {
        deviceType.image
    }
    var isBatteryLow: Bool {
        batteryState == .low
    }
    var isBatteryNormal: Bool {
        batteryState == .normal
    }
}


// MARK: - DeviceDTO

struct DeviceDTO: Codable {
    let deviceType: String
    let serialNo: String
    let batteryState: String?
}
