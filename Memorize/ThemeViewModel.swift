//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by Matt Free on 11/26/21.
//

import SwiftUI

class ThemeViewModel: ObservableObject {
    @Published var themes: [Theme] = [] {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey = "SavedThemes"
    
    init() {
        restoreFromUserDefaults()
        if themes.isEmpty {
            themes = [
                .init(name: "Vehicles", emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻" , "🚝"], color: .gray),
                .init(name: "Countries", emojis: ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇧🇳", "🇧🇬", "🇧🇫", "🇧🇮", "🇰🇭", "🇨🇲"], color: .mint),
                .init(name: "Devices", emojis: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "☎️", "📺", "📽", "📸"], color: .blue),
                .init(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️"], color: .purple),
                .init(name: "Christmas", emojis: ["🎄", "🎅", "🇨🇽", "🤶", "🧑‍🎄", "✝️", "🐑", "❄️", "☃️"], color: .green),
                .init(name: "Halloween", emojis: ["💀", "👻", "🎃", "🧙‍♀️", "🪦", "🏮", "🍭", "🍫", "🍬", "🌙"], color: .orange)
            ]
        }
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey), let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
}
