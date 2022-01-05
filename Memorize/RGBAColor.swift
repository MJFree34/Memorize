//
//  RGBAColor.swift
//  Memorize
//
//  Created by Matt Free on 1/3/22.
//

import SwiftUI

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}

extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}

extension Theme {
    var color: Color {
        return Color(rgbaColor: rgbaColor)
    }
    
    init(name: String, emojis: [String], color: Color) {
        self.init(name: name, emojis: emojis, rgbaColor: RGBAColor(color: color))
    }
}
