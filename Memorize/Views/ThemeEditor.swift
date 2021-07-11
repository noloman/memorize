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
    @State private var numPairs = 2
    @State private var validationAlertPresented = false
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $themeToEdit.name)
            }
            Section(header: Text("Emojis")) {
                TextField("Emojis", text: $themeToEdit.emojiSet)
            }
            Section(header: Text("Color")) {
                let selectedColor = $themeToEdit.color
                let colorsArray = [Color.black, Color.blue, Color.gray, Color.green, Color.orange, Color.pink, Color.purple, Color.red, Color.yellow]
                buildRectangles(selectedColor, colors: colorsArray)
            }
            Section(header: Text("Number of pairs of cards")) {
                Stepper(
                    "Number of pairs: \(numPairs)",
                    value: $numPairs, in: 2...100,
                    step: 1
                )
                .onChange(of: numPairs) { pairs in
                    themeToEdit.numPairCards = pairs
                }
            }
        }
        .alert(isPresented: $validationAlertPresented) {
            var titleText: String = ""
            if themeToEdit.emojiSet.count < 2 {
                titleText.append("The number of emojis must be bigger than 2")
            }
            if themeToEdit.name == "" {
                titleText.append("There should be a name")
            }
            return Alert(title: Text(titleText))
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
                    if !validate() {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
    func validate() -> Bool {
        validationAlertPresented = (themeToEdit.emojiSet.count < 2 || themeToEdit.name.isEmpty) ? true : false
        return validationAlertPresented
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
