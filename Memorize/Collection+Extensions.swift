//
//  Collection+Extensions.swift
//  Memorize
//
//  Created by Matt Free on 1/5/22.
//

import Foundation

extension Collection where Element: Identifiable {
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id})
    }
}
