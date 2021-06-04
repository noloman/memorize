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
            Button(action: { startGame() }) {
                Text("New game")
                    .font(.title)
            }
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                renderCard(for: card)
            }
            .foregroundColor(viewModel.theme.color)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private func startGame() {
        viewModel.initNewCollection()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView(viewModel: EmojiMemoryGame())
    }
}
