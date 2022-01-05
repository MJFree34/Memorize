//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Matt Free on 1/4/22.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    
    @State private var emojiMemoryGameDictionary: [Theme : EmojiMemoryGame] = [:]
    
    var body: some View {
        NavigationView {
            List(themeViewModel.themes) { theme in
                NavigationLink(destination: getDestination(for: theme)) {
                    themeRow(for: theme)
                }
            }
            .navigationTitle("Memorize")
        }
        .onChange(of: themeViewModel.themes) { newValue in
            updateGames(to: newValue)
        }
    }
    
    private func themeRow(for theme: Theme) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(theme.name)
                    .font(.title3)
                    .foregroundColor(theme.color)
                
                Text("\(theme.numberOfPairs)")
                    .font(.caption)
            }
            
            Text("All of " + theme.emojis.joined(separator: ""))
                .font(.footnote)
        }
    }
    
    private func getDestination(for theme: Theme) -> some View {
        if emojiMemoryGameDictionary[theme] == nil {
            let newGame = EmojiMemoryGame(theme: theme)
            emojiMemoryGameDictionary.updateValue(newGame, forKey: theme)
            return EmojiMemoryGameView(game: newGame)
        }
        return EmojiMemoryGameView(game: emojiMemoryGameDictionary[theme]!)
    }
    
    private func updateGames(to newThemes: [Theme]) {
        themeViewModel.themes.forEach { theme in
            if !newThemes.contains(theme), let themeIndex = themeViewModel.themes.firstIndex(of: theme) {
                themeViewModel.themes.remove(at: themeIndex)
            }
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
            .environmentObject(ThemeViewModel())
    }
}
