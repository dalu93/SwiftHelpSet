//
//  UIColorExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/9/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /**
     Initialize a `UIColor` instance by processing the hexadecimal value
     
     - parameter hex:   The hexadecimal value without the `#` char.
     - parameter alpha: The alpha value
     
     - returns: `UIColor` instance
     */
    public convenience init(_ hex: Int, withAlpha alpha: CGFloat = 1.0) {
        let components = (
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 08) & 0xff) / 255,
            blue: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(
            red: components.red,
            green: components.green,
            blue: components.blue,
            alpha: alpha
        )
    }
    
    /**
     Initialize a `UIColor` instance by processing the hexadecimal string
    
     - parameter hexString: The hexadecimal string
     - parameter alpha:     The alpha value
     
     - returns: `UIColor` instance
     */
    public convenience init(_ hexString: String, alpha: CGFloat = 1.0) {
        let hex = hexString.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask) / 255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask) / 255.0)
        let b = CGFloat(Float(Int(color) & mask) / 255.0)
        
        self.init(
            red: r,
            green: g,
            blue: b,
            alpha: alpha
        )
    }
    
    /**
     Initialize a `UIColor` instance by processing the original RGB values (not divided by 255)

     - parameter red:   The red value
     - parameter green: The green value
     - parameter blue:  The blue value
     - parameter alpha: The alpha value
     
     - returns: `UIColor` instance
     */
    public convenience init(realRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1)
    {
        self.init(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0,
            alpha: alpha
        )
    }
}
