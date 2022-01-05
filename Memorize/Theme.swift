//
//  Theme.swift
//  Memorize
//
//  Created by Matt Free on 11/26/21.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var emojis: [String]
    var rgbaColor: RGBAColor
    var numberOfPairs: Int
    
    var maxNumberOfPairs: Bool { emojis.count == numberOfPairs }

    init(name: String, emojis: [String], rgbaColor: RGBAColor) {
        self.name = name
        self.emojis = emojis
        self.rgbaColor = rgbaColor
        self.numberOfPairs = emojis.count
    }
}
