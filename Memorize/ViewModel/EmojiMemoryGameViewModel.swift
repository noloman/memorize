//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import Foundation
import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    private let numThemes = 5
    
    typealias Card = MemoryGame<String>.Card
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    @Published var theme: Theme = TravelTheme()
    
    @Published
    private var model: MemoryGame<String> = createMemoryGame(from: TravelTheme())
    
    var score: Int {
        get {
            model.score
        }
    }
    
    private static func createMemoryGame<T>(from theme: T) -> MemoryGame<String> where T: Theme {
        return MemoryGame<String>(numberOfPairOfCards: theme.numPairCards) { pairIndex in
            theme.emojiSet[pairIndex]
        }
    }   
    
    func initNewCollection() {
        switch Int.random(in: 1..<numThemes) {
        case 1:
            theme = FoodTheme()
            model = EmojiMemoryGameViewModel.createMemoryGame(from: theme as! FoodTheme)
        case 2:
            theme = AnimalsTheme()
            model = EmojiMemoryGameViewModel.createMemoryGame(from: theme as! AnimalsTheme)
        case 3:
            theme = ObjectsTheme()
            model = EmojiMemoryGameViewModel.createMemoryGame(from: theme as! ObjectsTheme)
        case 4:
            theme = ActivitiesTheme()
            model = EmojiMemoryGameViewModel.createMemoryGame(from: theme as! ActivitiesTheme)
        case 5:
            theme = SmileysTheme()
            model = EmojiMemoryGameViewModel.createMemoryGame(from: theme as! SmileysTheme)
        default:
            theme = TravelTheme()
            model = EmojiMemoryGameViewModel.createMemoryGame(from: theme as! TravelTheme)
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
