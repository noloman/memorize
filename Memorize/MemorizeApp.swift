//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Manuel Lorenzo (noloman) on 31/05/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
