//
//  ContentView.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

struct ContentView: View {
    let vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🚅", "🚂", "🚊", "🚉", "✈️", "🛫", "🛬", "🛩️", "💺", "🚤", "🛥️", "🛳️", "⛴️", "🚢", "🚃", "🚄", "🚆", "🚇", "🚈", "🚝", "🚞", "🚋", "🏍", "🛵", "🛺", "🚲", "🛴"]
    let healthyFoodEmojis = ["🥗","🥘","🍲","🥙","🧆","🍚","🍛","🍝", "🍜","🍞","🥔","🥕","🍊", "🍌","🍇","🍈","🍉"]
    let fastFoodEmojis = ["🍔","🌯","🍟","🌭", "🍕","🌮","🍩","🥯","🥧","🥞","🧁","🧇","🍫","🍰","🍦","🍧","🍨","🍪"]
    
    @State var emojis: [String] = []
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
                        CardView(emoji: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
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
            if emojis.isEmpty {
                initVehicles()
            }
        }
        .padding(.horizontal)
    }
    
    var vehicles: some View {
        VStack {
            Button(action: {
                initVehicles()
            }, label: {
                Text("🚗")
            })
            Text("Vehicles")
        }
    }
    
    var healthyFood: some View {
        VStack {
            Button(action: {
                initHealthyFood()
            }, label: {
                Text("🍲")
            })
            Text("Healthy food")
        }
    }
    
    var fastFood: some View {
        VStack {
            Button(action: {
                initFastFood()
            }, label: {
                Text("🍔")
            })
            Text("Fast food")
        }
    }
    
    func initVehicles() {
        emojis = vehicleEmojis.shuffled()
    }
    
    func initHealthyFood() {
        emojis = healthyFoodEmojis.shuffled()
    }
    
    func initFastFood() {
        emojis = fastFoodEmojis.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
