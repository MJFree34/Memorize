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
    @State private var editMode: EditMode = .inactive
    
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeViewModel.themes) { theme in
                    NavigationLink(destination: getDestination(for: theme)) {
                        themeRow(for: theme)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            withAnimation {
                                themeViewModel.themes.remove(theme)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            themeToEdit = theme
                        } label: {
                            Label("Edit", systemImage: "pencil.circle")
                        }
                        .tint(.yellow)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { themeViewModel.themes.remove(at: $0) }
                }
                .onMove { fromOffsets, toOffset in
                    themeViewModel.themes.move(fromOffsets: fromOffsets, toOffset: toOffset)
                }
            }
            .navigationTitle("Memorize")
            .sheet(item: $themeToEdit) {
                if themeViewModel.themes.first?.emojis.count ?? 0 < 2 {
                    _ = withAnimation {
                        themeViewModel.themes.removeFirst()
                    }
                }
            } content: { theme in
                ThemeEditorView(theme: $themeViewModel.themes[theme])
            }
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            themeViewModel.themes.insert(Theme(name: "", emojis: [], color: .black), at: 0)
                        }
                        themeToEdit = themeViewModel.themes.first
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .environment(\.editMode, $editMode)
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
                
                Text("\(theme.emojis.count)")
                    .font(.caption)
            }
            
            Text((theme.maxNumberOfPairs ? "All of " : "\(theme.numberOfPairs) pairs of ") + theme.emojis.joined(separator: ""))
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
