//
//  Cardify.swift
//  Memorize
//
//  Created by Manuel Lorenzo (noloman) on 09/06/2021.
//

import Foundation
import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(isFaceUp ? 1:0)
        }
    }
}

struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let fontScale: CGFloat = 0.7
    static let lineWidth: CGFloat = 3
    static let fontSize: CGFloat = 32
}