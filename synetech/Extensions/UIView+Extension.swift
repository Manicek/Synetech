//
// UIView+Extension.swift
//
// Created by Patrik Hora


import UIKit


public extension UIView {
    
    func addSubviews(_ subviews:[UIView]) {
        subviews.forEach { view in
            addSubview(view)
        }
    }
}
