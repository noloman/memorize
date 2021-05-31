//
//  CardView.swift
//  Memorize
//
//  Created by WF06FC on 31/05/2021.
//

import SwiftUI

struct CardView: View {
    @State var isFaceUp: Bool = true
    @State var emoji: String
    
    var body: some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(emoji)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(emoji: "🚙")
    }
}
