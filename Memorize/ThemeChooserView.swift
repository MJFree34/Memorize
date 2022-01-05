//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Matt Free on 1/4/22.
//

import SwiftUI

struct ThemeChooserView: View {
    @ObservedObject var themeViewModel: ThemeViewModel
    
    var body: some View {
        NavigationView {
            List(themeViewModel.themes) { theme in
                NavigationLink(destination: EmojiMemoryGameView(theme: theme)) {
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
            }
            .navigationTitle("Memorize")
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView(themeViewModel: ThemeViewModel())
    }
}
