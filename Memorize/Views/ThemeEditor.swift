//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Manuel Lorenzo (@noloman) on 09/07/2021.
//

import SwiftUI

struct ThemeEditor: View {
    @EnvironmentObject var themeStore: ThemeStore
    @Binding var themeToEdit: Theme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $themeToEdit.name)
                    .onChange(of: themeToEdit.name) { name in
                        
                    }
            }
            Section(header: Text("Emojis")) {
                TextField("Emojis", text: $themeToEdit.emojiSet)
                    .onChange(of: themeToEdit.emojiSet) { emojiSet in
                        
                    }
            }
            Section(header: Text("Color")) {
                let selectedColor = $themeToEdit.color
                let colorsArray = [Color.black, Color.blue, Color.gray, Color.green, Color.orange, Color.pink, Color.purple, Color.red, Color.yellow]
                buildRectangles(selectedColor, colors: colorsArray)
            }
        }
        .navigationTitle("Edit Faces")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    themeStore.removeTheme(at: 0)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO Store theme
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
    @ViewBuilder
    func buildRectangles(_ selectedColor: Binding<Color>, colors: [Color]) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    if (selectedColor.wrappedValue == color) {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(color)
                            .overlay (
                                Rectangle()
                                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, dash: [4]))
                                    .foregroundColor(Color.clear)
                            )
                    } else {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(color)
                            .onTapGesture {
                                themeToEdit.color = color
                            }
                    }
                }
            }
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(themeToEdit: .constant(ThemeStore().themes.first!))
    }
}
