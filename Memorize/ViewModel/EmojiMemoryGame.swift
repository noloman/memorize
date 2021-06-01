//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manu on 31/05/2021.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    private static var vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🚅", "🚂", "🚊", "🚉", "✈️", "🛫", "🛬", "🛩️", "💺", "🚤", "🛥️", "🛳️", "⛴️", "🚢", "🚃", "🚄", "🚆", "🚇", "🚈", "🚝", "🚞", "🚋", "🏍", "🛵", "🛺", "🚲", "🛴"]
    private static var healthyFoodEmojis = ["🥗","🥘","🍲","🥙","🧆","🍚","🍛","🍝", "🍜","🍞","🥔","🥕","🍊", "🍌","🍇","🍈","🍉"]
    private static var fastFoodEmojis = ["🍔","🌯","🍟","🌭", "🍕","🌮","🍩","🥯","🥧","🥞","🧁","🧇","🍫","🍰","🍦","🍧","🍨","🍪"]
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    private static func createMemoryGame(of: EmojiCollection = .vehicles) -> MemoryGame<String> {
        switch of {
        case .vehicles:
            return MemoryGame<String>(numberOfPairOfCards: vehicleEmojis.count) { pairIndex in
                EmojiMemoryGame.vehicleEmojis[pairIndex]
            }
        case .fastFood:
            return MemoryGame<String>(numberOfPairOfCards: fastFoodEmojis.count) { pairIndex in
                EmojiMemoryGame.fastFoodEmojis[pairIndex]
            }
        case .healthyFood:
            return MemoryGame<String>(numberOfPairOfCards: healthyFoodEmojis.count) { pairIndex in
                EmojiMemoryGame.healthyFoodEmojis[pairIndex]
            }
        }
    }
    
    func initNewCollection(_ collection: EmojiCollection) {
        model = EmojiMemoryGame.createMemoryGame(of: collection)
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

enum EmojiCollection {
    case vehicles, healthyFood, fastFood
}
