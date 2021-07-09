//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import Foundation
import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    @Published var theme: Theme
    @Published var model: MemoryGame<String>
    
    var score: Int {
        get {
            model.score
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.model = MemoryGame<String>(numberOfPairOfCards: theme.numPairCards) { pairIndex in
            return String(theme.emojiSet[pairIndex])
        }
    }
    
    func initNewCollection() {
        self.theme = ThemeStore().themes.first!
        self.model = EmojiMemoryGameViewModel.createMemoryGame(theme)
    }
    
    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairOfCards: theme.numPairCards) { pairIndex in
            return String(theme.emojiSet[pairIndex])
        }
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
