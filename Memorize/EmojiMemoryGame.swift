//
//  EmojiMemoryGame.swift
//  EmojiMemoryGame
//
//  Created by Matt Free on 8/12/21.
//

import SwiftUI

//class EmojiMemoryGame: ObservableObject {
//    typealias Card = MemoryGame<String>.Card
//
//    private static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻" , "🚝"]
//
//    private static func createMemoryGame() -> MemoryGame<String> {
//        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
//            emojis[pairIndex]
//        }
//    }
//
//    @Published private var model = createMemoryGame()
//
//    var cards: [Card] {
//        return model.cards
//    }
//
//    // MARK: - Intent(s)
//
//    func choose(_ card: Card) {
//        model.choose(card)
//    }
//
//    func shuffle() {
//        model.shuffle()
//    }
//
//    func restart() {
//        model = Self.createMemoryGame()
//    }
//}

// MARK: - Assignment VI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    static func randomTheme() -> Theme {
        Theme(variation: Theme.Variation.allCases.randomElement()!, numberOfPairs: 10)
    }

    static func makeMemoryGame(with theme: Theme) -> MemoryGame<String> {
        var numberOfPairs = theme.numberOfPairs
        var emojis = theme.variation.emojis

        if emojis.count < numberOfPairs {
            numberOfPairs = emojis.count
        } else {
            while emojis.count > numberOfPairs {
                let index = Int.random(in: 0..<emojis.count)
                emojis.remove(at: index)
            }
        }

        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String>
    
    private var theme: Theme

    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }

    var score: Int {
        model.score
    }

    var themeName: String {
        theme.variation.rawValue.capitalized
    }

    var fillColor: LinearGradient {
        switch theme.variation.fill {
        case .color(let colorType):
            switch colorType {
            case "gray":
                return LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
            case "purple":
                return LinearGradient(colors: [.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            case "orange":
                return LinearGradient(colors: [.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            default:
                return LinearGradient(colors: [.black], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        case .gradient(let gradientType):
            switch gradientType {
            case "mint":
                return LinearGradient(colors: [.mint, .mint.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
            case "blue":
                return LinearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
            case "green":
                return LinearGradient(colors: [.green, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            default:
                return LinearGradient(colors: [.black, .black.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }

    init(theme: Theme? = nil) {
        if let theme = theme {
            self.theme = theme
            model = Self.makeMemoryGame(with: self.theme)
        } else {
            self.theme = Self.randomTheme()
            model = Self.makeMemoryGame(with: self.theme)
        }
    }

    // MARK: - Intents

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func shuffle() {
        model.shuffle()
    }

    func newGame() {
        self.theme = Self.randomTheme()
        model = Self.makeMemoryGame(with: self.theme)
    }
}

// MARK: - Assignment II

//struct Theme {
//    enum Variation: String, CaseIterable {
//        enum Fill {
//            case color(String)
//            case gradient(String)
//        }
//
//        case vehicles
//        case countries
//        case devices
//        case sports
//        case christmas
//        case halloween
//
//        var emojis: [String] {
//            switch self {
//            case .vehicles:
//                return ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻" , "🚝"]
//            case .countries:
//                return ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇧🇳", "🇧🇬", "🇧🇫", "🇧🇮", "🇰🇭", "🇨🇲"]
//            case .devices:
//                return ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "☎️", "📺", "📽", "📸"]
//            case .sports:
//                return ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️"]
//            case .christmas:
//                return ["🎄", "🎅", "🇨🇽", "🤶", "🧑‍🎄", "✝️", "🐑", "❄️", "☃️"]
//            case .halloween:
//                return ["💀", "👻", "🎃", "🧙‍♀️", "🪦", "🏮", "🍭", "🍫", "🍬", "🌙"]
//            }
//        }
//
//        var fill: Fill {
//            switch self {
//            case .vehicles:
//                return .color("gray")
//            case .countries:
//                return .gradient("mint")
//            case .devices:
//                return .gradient("blue")
//            case .sports:
//                return .color("purple")
//            case .christmas:
//                return .gradient("green")
//            case .halloween:
//                return .color("orange")
//            }
//        }
//
//        var numberOfCards: Int {
//            switch self {
//            case .vehicles, .countries, .devices:
//                return Int.random(in: 4..<emojis.count)
//            case .sports, .christmas, .halloween:
//                return emojis.count
//            }
//        }
//    }
//
//    let variation: Variation
//    let numberOfPairs: Int
//
//    init(variation: Variation, numberOfPairs: Int? = nil) {
//        self.variation = variation
//
//        if let numberOfPairs = numberOfPairs {
//            self.numberOfPairs = numberOfPairs
//        } else {
//            self.numberOfPairs = variation.numberOfCards
//        }
//    }
//}
//
//class EmojiMemoryGame: ObservableObject {
//    static func randomTheme() -> Theme {
//        Theme(variation: Theme.Variation.allCases.randomElement()!, numberOfPairs: 10)
//    }
//
//    static func makeMemoryGame(with theme: Theme) -> MemoryGame<String> {
//        var numberOfPairs = theme.numberOfPairs
//        var emojis = theme.variation.emojis
//
//        if emojis.count < numberOfPairs {
//            numberOfPairs = emojis.count
//        } else {
//            while emojis.count > numberOfPairs {
//                let index = Int.random(in: 0..<emojis.count)
//                emojis.remove(at: index)
//            }
//        }
//
//        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
//            emojis[pairIndex]
//        }
//    }
//
//    @Published private var model: MemoryGame<String>
//    private var theme: Theme
//
//    var cards: [MemoryGame<String>.Card] {
//        return model.cards
//    }
//
//    var score: Int {
//        model.score
//    }
//
//    var themeName: String {
//        theme.variation.rawValue.capitalized
//    }
//
//    var fillColor: LinearGradient {
//        switch theme.variation.fill {
//        case .color(let colorType):
//            switch colorType {
//            case "gray":
//                return LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
//            case "purple":
//                return LinearGradient(colors: [.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
//            case "orange":
//                return LinearGradient(colors: [.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
//            default:
//                return LinearGradient(colors: [.black], startPoint: .topLeading, endPoint: .bottomTrailing)
//            }
//        case .gradient(let gradientType):
//            switch gradientType {
//            case "mint":
//                return LinearGradient(colors: [.mint, .mint.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
//            case "blue":
//                return LinearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
//            case "green":
//                return LinearGradient(colors: [.green, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            default:
//                return LinearGradient(colors: [.black, .black.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
//            }
//        }
//    }
//
//    init(theme: Theme? = nil) {
//        if let theme = theme {
//            self.theme = theme
//            model = Self.makeMemoryGame(with: self.theme)
//        } else {
//            self.theme = Self.randomTheme()
//            model = Self.makeMemoryGame(with: self.theme)
//        }
//    }
//
//    func newGame() {
//        self.theme = Self.randomTheme()
//        model = Self.makeMemoryGame(with: self.theme)
//    }
//
//    // MARK: - Intents
//
//    func choose(_ card: MemoryGame<String>.Card) {
//        model.choose(card)
//    }
//}
