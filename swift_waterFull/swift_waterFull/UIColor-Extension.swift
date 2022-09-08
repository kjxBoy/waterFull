//
//  UIColor-Extension.swift
//  waterFull
//
//  Created by KJX on 2022/9/8.
//

import UIKit

extension UIColor {
    // 在extension中给系统的类扩充构造函数,只能扩充`便利构造函数`
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 16进制颜色
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex: String, alpha : CGFloat = 1.0) {
        var start = hex.startIndex

        if hex.hasPrefix("#") {
            start = hex.index(hex.startIndex, offsetBy: 1)
        }
        let hexColor = String(hex[start...])

        if hexColor.count == 6 {
           let scanner = Scanner(string: hexColor)
           var hexNumber: UInt64 = 0
           if scanner.scanHexInt64(&hexNumber) {
               self.init(hex: Int(hexNumber), alpha: alpha)
               return
           }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func getRGBDelta(_ firstColor : UIColor, _ seccondColor : UIColor) -> (CGFloat, CGFloat,  CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secondRGB = seccondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("保证普通颜色是RGB方式传入")
        }
        
        return (cmps[0] * 255, cmps[1] * 255, cmps[2] * 255)
    }
}
