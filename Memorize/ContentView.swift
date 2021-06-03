//
//  ContentView.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                renderCard(for: card)
            }
            .foregroundColor(.red)
            Spacer()
            EmojiTypeView(viewModel: viewModel)
        }
        .onAppear {
            if viewModel.cards.isEmpty {
                viewModel.initNewCollection(.vehicles)
            }
        }
        .padding(.horizontal)
    }
    
    private func startGame(collection: EmojiCollection) {
        viewModel.initNewCollection(collection)
    }
    
    @ViewBuilder
    func renderCard(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .aspectRatio(2/3, contentMode: .fit)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

private struct EmojiTypeView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var vehicles: some View {
        VStack {
            Button(action: {
                viewModel.initNewCollection(.vehicles)
            }, label: {
                Text("🚗")
            })
            Text("Vehicles")
        }
    }
    var fastFood: some View {
        VStack {
            Button(action: {
                viewModel.initNewCollection(.fastFood)
            }, label: {
                Text("🍔")
            })
            Text("Fast food")
        }
    }
    var healthyFood: some View {
        VStack {
            Button(action: {
                viewModel.initNewCollection(.healthyFood)
            }, label: {
                Text("🍲")
            })
            Text("Healthy food")
        }
    }
    var body: some View {
        HStack {
            vehicles
            Spacer()
            fastFood
            Spacer()
            healthyFood
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return ContentView(viewModel: game)
    }
}
