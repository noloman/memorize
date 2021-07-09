//
//  ContentView.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

struct ThemeChooserView: View {
    @State private var themeStore = ThemeStore()
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.themes, id: \.self) { theme in
                    NavigationLink(destination: MemorizeView(theme: theme)) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .foregroundColor(theme.color)
                            Text("\(theme.emojiSet)")
                                .lineLimit(1)
                        }
                    }
                }
            }
            .navigationBarTitle("Memorize")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
    }
}
