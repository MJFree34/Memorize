//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Matt Free on 8/10/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeChooserView(themeViewModel: ThemeViewModel())
        }
    }
}
