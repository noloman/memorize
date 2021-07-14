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
    
    private(set) var theme: Theme
    @Published private var model: MemoryGame<String>
    
    var themeName: String {
        get { theme.name }
    }
    
    var score: Int {
        get { model.score }
    }
    
    // MARK: - init
    init(with theme: Theme) {
        self.theme = theme
        model = MemoryGame<String>(numberOfPairOfCards: theme.numPairCards) { pairIndex in
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
    
    func resetGame() {
        model = MemoryGame<String>(numberOfPairOfCards: theme.numPairCards) { pairIndex in
            return String(theme.emojiSet[pairIndex])
        }
    }
}
