//
//  Utilities.swift
//  Cognitive Diary
//
//  Created by Andrea Mancini on 08/10/2020.
//

import UIKit

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgbHexValue: String) {
        assert(rgbHexValue.count == 6)
        
        let red = UInt8(rgbHexValue.substring(with: 0..<2), radix: 16)
        let green = UInt8(rgbHexValue.substring(with: 2..<4), radix: 16)
        let blue = UInt8(rgbHexValue.substring(with: 4..<6), radix: 16)
        
        self.init(red: CGFloat(red!) / 255.0, green: CGFloat(green!) / 255.0, blue: CGFloat(blue!) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

public extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
