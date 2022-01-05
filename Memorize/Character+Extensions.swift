//
//  Character+Extensions.swift
//  Memorize
//
//  Created by Matt Free on 1/5/22.
//

import Foundation

extension Character {
    var isEmoji: Bool {
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}
