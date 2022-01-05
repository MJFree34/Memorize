//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Matt Free on 8/12/21.
//

import Foundation

//struct MemoryGame<CardContent> where CardContent: Equatable {
//    private(set) var cards: [Card]
//
//    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
//        get {
//           cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//        }
//
//        set {
//            cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }
//        }
//    }
//
//    mutating func choose(_ card: Card) {
//        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
//           !cards[chosenIndex].isFaceUp,
//           !cards[chosenIndex].isMatched
//        {
//            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
//                    cards[chosenIndex].isMatched = true
//                    cards[potentialMatchIndex].isMatched = true
//                }
//                cards[chosenIndex].isFaceUp = true
//            } else {
//                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
//            }
//        }
//    }
//
//    mutating func shuffle() {
//        cards.shuffle()
//    }
//
//    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
//        cards = []
//
//        for pairIndex in 0..<numberOfPairsOfCards {
//            let content = createCardContent(pairIndex)
//            cards.append(Card(content: content, id: pairIndex * 2))
//            cards.append(Card(content: content, id: pairIndex * 2 + 1))
//        }
//
//        cards.shuffle()
//    }
//
//    struct Card: Identifiable {
//        var isFaceUp = false {
//            didSet {
//                if isFaceUp {
//                    startUsingBonusTime()
//                } else {
//                    stopUsingBonusTime()
//                }
//            }
//        }
//        var isMatched = false
//        let content: CardContent
//        let id: Int
//
//        // MARK: - Bonus Time
//
//        // Can be zero which means "no bonus time available" for this car
//        var bonusTimeLimit: TimeInterval = 6
//
//        // How long this card has ever been face up
//        private var faceUpTime: TimeInterval {
//            if let lastFaceUpDate = lastFaceUpDate {
//                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
//            } else {
//                return pastFaceUpTime
//            }
//        }
//
//        // The last time this card was turned face up (and is still face up)
//        var lastFaceUpDate: Date?
//
//        // The accumulated time this card has been face up in the past
//        var pastFaceUpTime: TimeInterval = 0
//
//        // Howmuch time left before opportunity runs out
//        var bonusTimeRemaining: TimeInterval {
//            max(0, bonusTimeLimit - faceUpTime)
//        }
//
//        // Percentage of the bonus time remaining
//        var bonusRemaining: Double {
//            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
//        }
//
//        // Whether the card was matched during the bonus time period
//        var hasEarnedBonus: Bool {
//            isMatched && bonusTimeRemaining > 0
//        }
//
//        // Whether we are currently face up, unmatched, and have not yet used up the bonus window
//        var isConsumingBonusTime: Bool {
//            isFaceUp && !isMatched && bonusTimeRemaining > 0
//        }
//
//        // Called when the card transitions to face up state
//        private mutating func startUsingBonusTime() {
//            if isConsumingBonusTime, lastFaceUpDate == nil {
//                lastFaceUpDate = Date()
//            }
//        }
//
//        // Called when the card goes back face down or gets matched
//        private mutating func stopUsingBonusTime() {
//            pastFaceUpTime = faceUpTime
//            lastFaceUpDate = nil
//        }
//    }
//}
//
//extension Array {
//    var oneAndOnly: Element? {
//        if count == 1 {
//            return first
//        }
//        return nil
//    }
//}

// MARK: - Assignment VI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    private var lastPairTappedTime: Date?
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        
        set {
            cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    calculateScore(correct: true)
                } else {
                    if cards[chosenIndex].isPreviouslySeen {
                        calculateScore(correct: false)
                    }
                    
                    if cards[potentialMatchIndex].isPreviouslySeen {
                        calculateScore(correct: false)
                    }
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
                cards[chosenIndex].isFaceUp = true
                cards[potentialMatchIndex].isFaceUp = true
                lastPairTappedTime = Date()
                cards[chosenIndex].isPreviouslySeen = true
                cards[potentialMatchIndex].isPreviouslySeen = true
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating private func calculateScore(correct: Bool) {
        var addedScore = 1
        
        if let lastPairTappedTime = lastPairTappedTime {
            let difference = Int(abs(lastPairTappedTime.timeIntervalSinceNow))
            let max = max(5 - difference, 1)
            addedScore = max
        }
        
        if correct {
            score += addedScore * 2
        } else {
            score -= 1
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false
        var isPreviouslySeen = false
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        
        // Can be zero which means "no bonus time available" for this car
        var bonusTimeLimit: TimeInterval = 6
        
        // How long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // The last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // The accumulated time this card has been face up in the past
        var pastFaceUpTime: TimeInterval = 0
        
        // Howmuch time left before opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // Percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // Whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // Whether we are currently face up, unmatched, and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // Called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // Called when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        }
        return nil
    }
}

// MARK: - Assignment II

//struct MemoryGame<CardContent> where CardContent: Equatable {
//    private(set) var cards: [Card]
//    private(set) var score = 0
//
//    private var lastPairTappedTime: Date?
//    private var indexOfTheOneAndOnlyFaceUpCard: Int?
//
//    mutating func choose(_ card: Card) {
//        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
//           !cards[chosenIndex].isFaceUp,
//           !cards[chosenIndex].isMatched
//        {
//            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
//                    cards[chosenIndex].isMatched = true
//                    cards[potentialMatchIndex].isMatched = true
//
//                    calculateScore(correct: true)
//                } else {
//                    if cards[chosenIndex].isPreviouslySeen {
//                        calculateScore(correct: false)
//                    }
//
//                    if cards[potentialMatchIndex].isPreviouslySeen {
//                        calculateScore(correct: false)
//                    }
//                }
//
//                indexOfTheOneAndOnlyFaceUpCard = nil
//                lastPairTappedTime = Date()
//                cards[chosenIndex].isPreviouslySeen = true
//                cards[potentialMatchIndex].isPreviouslySeen = true
//            } else {
//                for index in cards.indices {
//                    cards[index].isFaceUp = false
//                }
//
//                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
//            }
//
//            cards[chosenIndex].isFaceUp.toggle()
//        }
//    }
//
//    mutating private func calculateScore(correct: Bool) {
//        var addedScore = 1
//
//        if let lastPairTappedTime = lastPairTappedTime {
//            let difference = Int(abs(lastPairTappedTime.timeIntervalSinceNow))
//            let max = max(5 - difference, 1)
//            addedScore = max
//        }
//
//        if correct {
//            score += addedScore * 2
//        } else {
//            score -= 1
//        }
//    }
//
//    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
//        cards = []
//        // add numberOfPairsOfCards x 2 to cards array
//        for pairIndex in 0..<numberOfPairsOfCards {
//            let content = createCardContent(pairIndex)
//            cards.append(Card(content: content, id: pairIndex * 2))
//            cards.append(Card(content: content, id: pairIndex * 2 + 1))
//        }
//
//        cards.shuffle()
//    }
//
//    struct Card: Identifiable {
//        var isFaceUp = false
//        var isMatched = false
//        var isPreviouslySeen = false
//        var content: CardContent
//        var id: Int
//    }
//}
