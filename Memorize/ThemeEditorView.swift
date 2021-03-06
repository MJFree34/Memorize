//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Matt Free on 1/5/22.
//

import SwiftUI

struct ThemeEditorView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var theme: Theme
    
    @State private var name: String
    @State private var emojis: [String]
    @State private var numberOfPairs: Int
    @State private var color: Color
    @State private var emojisToAdd = ""
    
    init(theme: Binding<Theme>) {
        _theme = theme
        _name = State(initialValue: theme.wrappedValue.name)
        _numberOfPairs = State(initialValue: theme.wrappedValue.numberOfPairs)
        _emojis = State(initialValue: theme.wrappedValue.emojis)
        _color = State(initialValue: theme.wrappedValue.color)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Theme Name") {
                    TextField("Theme Name", text: $name)
                }
                
                Section(header: emojisHeader) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))], alignment: .center) {
                        ForEach(emojis) { emoji in
                            Text(emoji)
                                .onTapGesture {
                                    withAnimation {
                                        emojis.remove(emoji)
                                        if numberOfPairs > emojis.count {
                                            numberOfPairs = emojis.count
                                        }
                                    }
                                }
                        }
                    }
                }
                
                Section("Add Emojis") {
                    TextField("Emojis", text: $emojisToAdd)
                        .onChange(of: emojisToAdd) { newEmoji in
                            withAnimation {
                                if emojisToAdd.count > 1 {
                                    emojisToAdd.removeFirst(emojisToAdd.count - 1)
                                } else {
                                    addEmoji(newEmoji)
                                }
                            }
                        }
                }
                
                Section("Number of Pairs") {
                    Stepper("\(emojis.count == numberOfPairs ? "All" : "\(numberOfPairs)") Pairs", value: $numberOfPairs, in: emojis.count > 2 ? 2...emojis.count : 2...2)
                }
                
                Section("Color") {
                    ColorPicker(selection: $color) {
                        Text("Current Color")
                            .foregroundColor(color)
                    }
                }
            }
            .navigationTitle(theme.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        save()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var emojisHeader: some View {
        HStack {
            Text("Emojis")
                .font(.caption)
            Spacer()
            Text("Tap to Delete")
                .font(.caption2)
        }
    }
    
    private func addEmoji(_ emoji: String) {
        if emoji.allSatisfy({ $0.isEmoji }) && !emojis.contains(emoji) {
            emojis.append(emoji)
        }
    }
    
    private func save() {
        theme.name = name
        theme.emojis = emojis
        theme.numberOfPairs = numberOfPairs
        theme.rgbaColor = RGBAColor(color: color)
    }
}

struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView(theme: .constant(ThemeViewModel().themes[0]))
    }
}
