//
//  ContentView.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    @Namespace private var dealingNamespace
    
    @State private var dealt = Set<Int>()
    
    var gameBody: some View {
        VStack {
            HStack {
                Button(action: { startGame() }) {
                    Text("New game")
                        .font(.title)
                }
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                renderCard(for: card)
            }
            .foregroundColor(viewModel.theme.color)
            Spacer()
        }
    }
    
    var body: some View {
        VStack {
            gameBody
            deckBody
            shuffle
        }
        .padding(.horizontal)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
        .padding(.vertical)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealthWidth, height: CardConstants.undealtHeight)
        .foregroundColor(viewModel.theme.color)
        .onTapGesture {
            // "deal" cards
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    @ViewBuilder
    private func renderCard(for card: EmojiMemoryGameViewModel.Card) -> some View {
        if isUndealt(card) || card.isMatched && !card.isFaceUp {
            Color.clear
        } else {
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(.asymmetric(insertion: .scale, removal: .identity))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func isUndealt(_ card: EmojiMemoryGameViewModel.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func deal(_ card: EmojiMemoryGameViewModel.Card) {
        dealt.insert(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGameViewModel.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func startGame() {
        viewModel.initNewCollection()
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio = 2/3
        static let dealDuration = 0.5
        static let totalDealDuration: Double = 2.0
        static let undealtHeight: CGFloat = 90
        static let undealthWidth: CGFloat = 60
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(game.cards.first!)
        return ContentView(viewModel: game)
    }
}
