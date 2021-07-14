//
//  ThemeStore.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 08/07/2021.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes = [Theme]()
    
    init() {
        initNewCollection()
    }
    
    private func initNewCollection() {
        insertTheme(named: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜", color: .gray)
        insertTheme(named: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳", color: .blue)
        insertTheme(named: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻", color: .yellow)
        insertTheme(named: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲", color: .green)
        insertTheme(named: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻", color: .orange)
        insertTheme(named: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪", color: .purple)
        insertTheme(named: "COVID", emojis: "💉🦠😷🤧🤒", color: .red)
        insertTheme(named: "Faces", emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠", color: .pink)
    }
    
    func insertTheme(named name: String, emojis: String? = nil, at index: Int = 0, color: Color) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        var theme: Theme
        if let emojis = emojis {
            theme = Theme(id: unique, name: name, emojiSet: emojis, color: color, numPairCards: emojis.count)
        } else {
            theme = Theme(id: unique, name: name, emojiSet: "👍👎", color: color, numPairCards: 2)
        }
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
    
    func removeTheme(at: Int) {
        themes.remove(at: at)
    }
}
