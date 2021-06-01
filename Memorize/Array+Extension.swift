//
//  Array+Extension.swift
//  Memorize
//
//  Created by WF06FC on 01/06/2021.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
