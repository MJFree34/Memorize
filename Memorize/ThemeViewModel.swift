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
                .init(name: "Vehicles", emojis: ["ðē", "ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð", "âïļ", "ð", "âĩïļ", "ðļ", "ðķ", "ð", "ð", "ðš", "ð ", "ðĩ", "ð", "ð", "ð", "ðŧ" , "ð"], color: .gray),
                .init(name: "Countries", emojis: ["ðĶðŦ", "ðĶð―", "ðĶðą", "ðĐðŋ", "ðĶðļ", "ðĶðĐ", "ðĶðī", "ðĶðŪ", "ðĶðķ", "ðĶðŽ", "ðĶð·", "ðĶðē", "ðĶðž", "ðĶðš", "ð§ðģ", "ð§ðŽ", "ð§ðŦ", "ð§ðŪ", "ð°ð­", "ðĻðē"], color: .mint),
                .init(name: "Devices", emojis: ["âïļ", "ðą", "ðŧ", "âĻïļ", "ðĨ", "ðĻ", "ðą", "âïļ", "ðš", "ð―", "ðļ"], color: .blue),
                .init(name: "Sports", emojis: ["â―ïļ", "ð", "ð", "âūïļ", "ðĨ", "ðū", "ð", "ð", "ðĨ", "ðą", "ðŠ", "ð", "ðļ", "ð", "ð", "ðĨ", "ð", "ðŠ", "ðĨ", "âģïļ"], color: .purple),
                .init(name: "Christmas", emojis: ["ð", "ð", "ðĻð―", "ðĪķ", "ð§âð", "âïļ", "ð", "âïļ", "âïļ"], color: .green),
                .init(name: "Halloween", emojis: ["ð", "ðŧ", "ð", "ð§ââïļ", "ðŠĶ", "ðŪ", "ð­", "ðŦ", "ðŽ", "ð"], color: .orange)
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
