//
//  Extensions.swift
//  WeatherApp
//
//  Created by Daniil KOZYR on 7/17/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func convertFromFahrenheitToCelsius() -> Int {
        return Int((5.0 / 9.0 * (self - 32.0)).rounded())
    }
}

extension UIView {
    func setGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    struct Theme {
        static let darkBlue = UIColor(red: 63/255, green: 43/255, blue: 150/255, alpha: 1.0)
        static let lightBlue = UIColor(red: 0/255, green: 90/255, blue: 167/255, alpha: 1.0)
    }
}
