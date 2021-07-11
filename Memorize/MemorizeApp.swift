//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let themeStore = ThemeStore()
    var body: some Scene {
        WindowGroup {
            ThemeChooserView()
                .environmentObject(themeStore)
        }
    }
    
}
