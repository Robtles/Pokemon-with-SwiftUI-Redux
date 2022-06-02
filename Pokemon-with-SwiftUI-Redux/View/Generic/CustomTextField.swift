//
//  CustomTextField.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 27/05/2022.
//

import SwiftUI

// MARK: - Custom Text Field
/// A text field with custom style
struct CustomTextField: View {
    /// The text field placeholder
    let placeholderText: String
    /// The text field text
    @Binding var text: String
    
    // MARK: View Properties
    var body: some View {
        ZStack {
            TextField("", text: $text)
                .frame(height: 32.0)
                .font(Style.Font.regular(sized: 16.0))
                .foregroundColor(Style.Color.blackText)
                .modifier(
                    TextFieldModifier(
                        showPlaceholder: text.isEmpty,
                        placeholder: placeholderText
                    )
                )
                .padding(12)
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(
                    color: Color.gray.opacity(0.2),
                    radius: 12.0
                )
        }
    }
}

// MARK: - Text Field Modifier
/// A modifier to apply style to text fields
private struct TextFieldModifier: ViewModifier {
    // MARK: Instance Properties
    var showPlaceholder: Bool
    var placeholder: String
    
    // MARK: View Methods
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceholder {
                Text(placeholder)
                    .font(Style.Font.regular(sized: 16.0))
                    .foregroundColor(Style.Color.grayText)
            }
            content
        }
    }
}

#if DEBUG
struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
            VStack(spacing: 16) {
                CustomTextField(
                    placeholderText: "A custom placeholder",
                    text: .constant("A custom text")
                )
                CustomTextField(
                    placeholderText: "A custom placeholder",
                    text: .constant("")
                )
            }
        }
        .ignoresSafeArea()
    }
}
#endif
