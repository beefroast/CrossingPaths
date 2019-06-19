//
//  UIColorExtensions.swift
//  Crossing Paths
//
//  Created by Benjamin Frost on 19/6/19.
//  Copyright © 2019 Benjamin Frost. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    static var cpMauve: UIColor { return UIColor(hex: 0xDCA4C2) }
    static var cpLavender: UIColor { return UIColor(hex: 0xC7CCF4) }
    static var cpPinktan: UIColor { return UIColor(hex: 0xCCA899) }
    static var cpBlue: UIColor { return UIColor(hex: 0x7892D0) }
    static var cpYellow: UIColor { return UIColor(hex: 0xE9EDB1) }
    static var cpOrangered: UIColor { return UIColor(hex: 0xEC9780) }
    static var cpGreen: UIColor { return UIColor(hex: 0xB0F0C8) }
    static var cpOrange: UIColor { return UIColor(hex: 0xF3C68F) }
    
    
}


