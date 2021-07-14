//
//  ContentView.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 31/05/2021.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var themeStore: ThemeStore
    @State private var themeToEdit: Theme?
    @State private var editMode: EditMode = .inactive
    
    func tap(_ theme: Theme) -> some Gesture {
        TapGesture()
            .onEnded {
                themeToEdit = themeStore.themes[theme]
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.themes.indices, id: \.self) { index in
                    NavigationLink(destination: MemorizeView(viewModel: EmojiMemoryGameViewModel(with: themeStore.themes[index]))) {
                        VStack(alignment: .leading) {
                            Text(themeStore.themes[index].name).foregroundColor(themeStore.themes[index].color)
                            Text("\(themeStore.themes[index].emojiSet)").lineLimit(1)
                        }
                    }
                    .gesture(editMode == .active ? tap(themeStore.themes[index]) : nil)
                }.onDelete { indexSet in
                    themeStore.themes.remove(atOffsets: indexSet)
                }
                .onMove { fromIndexSet, toIndexSet in
                    themeStore.themes.move(fromOffsets: fromIndexSet, toOffset: toIndexSet)
                }
            }
            .navigationBarTitle("Memorize")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        themeStore.insertTheme(named: "", emojis: nil, at: 0, color: .blue)
                        themeToEdit = themeStore.themes.first
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(item: $themeToEdit,
                   onDismiss: {
                    if let theme = $themeToEdit.wrappedValue, theme.isEmpty() {
                        themeStore.removeTheme(at: 0)
                    }
                   }) { theme in
                NavigationView {
                    ThemeEditor(themeToEdit: $themeStore.themes[theme])
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
            .environmentObject(ThemeStore())
    }
}