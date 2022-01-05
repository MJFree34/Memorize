//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Matt Free on 8/10/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeViewModel = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserView()
                .environmentObject(themeViewModel)
        }
    }
}
