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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.cards[0..<viewModel.cards.count]) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehicles
                Spacer()
                fastFood
                Spacer()
                healthyFood
            }
        }
        .onAppear {
            if viewModel.cards.isEmpty {
                viewModel.initNewCollection(.vehicles)
            }
        }
        .padding(.horizontal)
    }
    
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
    
    func startGame(collection: EmojiCollection) {
        viewModel.initNewCollection(collection)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
