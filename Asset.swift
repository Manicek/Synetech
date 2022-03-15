//
// Asset.swift
//
// Created by Patrik Hora


import UIKit


enum Asset {
    
    // I own these assets and now I finally found a use for them :D
    
    static let bu01 = image(name: "Image")
    static let by01 = image(name: "Image-1")
    static let ib01 = image(name: "Image-2")
    static let ru01 = image(name: "Image-3")
    static let su02 = image(name: "Image-4")
    static let ts02 = image(name: "Image-5")
    static let va01 = image(name: "Image-6")
    static let wr01 = image(name: "Image-7")
    
    static let lowBattery = image(name: "lowBattery")
        
    private static func image(name: String) -> UIImage {
        if let image = UIImage(name) {
            return image
        }
        print("Error: Failed to create image for name: \(name)")
        return UIImage()
    }
}
