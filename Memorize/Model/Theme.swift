//
//  Theme.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 03/06/2021.
//

import Foundation
import SwiftUI

struct Theme: Hashable, Identifiable {
    var id: Int
    var name: String
    var emojiSet: String
    var color: Color
    var numPairCards: Int
}
