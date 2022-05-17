//
//  Style+Font.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 16/05/2022.
//

import SwiftUI

// MARK: - App Fonts
extension Style {
    // MARK: Type Properties
    private struct FontName {
        static let bold = "Outfit-Bold"
        static let semibold = "Outfit-SemiBold"
    }
    
    struct Font {
        // MARK: Font Getters
        static func bold(sized: Double) -> SwiftUI.Font {
            return SwiftUI.Font.custom(FontName.bold, size: sized)
        }
        
        static func semibold(sized: Double) -> SwiftUI.Font {
            return SwiftUI.Font.custom(FontName.semibold, size: sized)
        }
    }
}
