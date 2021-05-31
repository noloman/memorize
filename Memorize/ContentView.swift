//
//  ContentView.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🚅", "🚂", "🚊", "🚉", "✈️", "🛫", "🛬", "🛩️", "💺", "🚤", "🛥️", "🛳️", "⛴️", "🚢", "🚃", "🚄", "🚆", "🚇", "🚈", "🚝", "🚞", "🚋", "🏍", "🛵", "🛺", "🚲", "🛴"]
    @State var emojiCount = 20
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0 ..< emojiCount], id: \.self) { emoji in
                        CardView(emoji: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                addButton
                Spacer()
                Text("Shuffle")
                Spacer()
                removeButton
            }
            .font(.largeTitle)
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    var addButton: some View {
        Button(action: {
            emojiCount += 1
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
    
    var removeButton: some View {
        Button(action: {
            emojiCount -= 1
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
