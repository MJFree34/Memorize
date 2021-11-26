//
//  Theme.swift
//  Memorize
//
//  Created by Matt Free on 11/26/21.
//

import Foundation

struct Theme {
    enum Variation: String, CaseIterable {
        enum Fill {
            case color(String)
            case gradient(String)
        }

        case vehicles
        case countries
        case devices
        case sports
        case christmas
        case halloween

        var emojis: [String] {
            switch self {
            case .vehicles:
                return ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻" , "🚝"]
            case .countries:
                return ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇧🇳", "🇧🇬", "🇧🇫", "🇧🇮", "🇰🇭", "🇨🇲"]
            case .devices:
                return ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "☎️", "📺", "📽", "📸"]
            case .sports:
                return ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️"]
            case .christmas:
                return ["🎄", "🎅", "🇨🇽", "🤶", "🧑‍🎄", "✝️", "🐑", "❄️", "☃️"]
            case .halloween:
                return ["💀", "👻", "🎃", "🧙‍♀️", "🪦", "🏮", "🍭", "🍫", "🍬", "🌙"]
            }
        }

        var fill: Fill {
            switch self {
            case .vehicles:
                return .color("gray")
            case .countries:
                return .gradient("mint")
            case .devices:
                return .gradient("blue")
            case .sports:
                return .color("purple")
            case .christmas:
                return .gradient("green")
            case .halloween:
                return .color("orange")
            }
        }

        var numberOfCards: Int {
            switch self {
            case .vehicles, .countries, .devices:
                return Int.random(in: 4..<emojis.count)
            case .sports, .christmas, .halloween:
                return emojis.count
            }
        }
    }

    let variation: Variation
    let numberOfPairs: Int

    init(variation: Variation, numberOfPairs: Int? = nil) {
        self.variation = variation

        if let numberOfPairs = numberOfPairs {
            self.numberOfPairs = numberOfPairs
        } else {
            self.numberOfPairs = variation.numberOfCards
        }
    }
}
