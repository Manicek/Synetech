//
// UIImage+Extension.swift
//
// Created by Patrik Hora


import UIKit


public extension UIImage {

    convenience init?(_ name: String) {
        self.init(named: name, in: Bundle.main, with: nil)
    }
}
