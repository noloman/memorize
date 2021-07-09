//
//  Cardify.swift
//  Memorize
//
//  Created by Manuel Lorenzo (noloman) on 09/06/2021.
//

import Foundation
import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double // in degrees
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0:180
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}

struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let fontScale: CGFloat = 0.7
    static let lineWidth: CGFloat = 3
    static let fontSize: CGFloat = 32
}
