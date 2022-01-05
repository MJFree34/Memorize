//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by Matt Free on 11/26/21.
//

import SwiftUI

class ThemeViewModel: ObservableObject {
    @Published var themes: [Theme]
    
    init() {
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
