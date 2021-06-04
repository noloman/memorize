//
//  Theme.swift
//  Memorize
//
//  Created by Manuel Lorenzo (noloman) on 03/06/2021.
//

import Foundation
import SwiftUI

protocol Theme {
    var emojiSet: Array<String> { get }
    var color: Color { get }
    var numPairCards: Int { get }
}
