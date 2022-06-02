//
//  Style+Image.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 16/05/2022.
//

import SwiftUI

// MARK: - App Images
extension Style {
    /// The image resources container
    enum Image: String {
        case crossButton = "CrossButton"
        case pokeBallIcon = "PokeBallIcon"
        case unknownPlaceholder = "UnknownPlaceholder"
    }
    
    // MARK: Methods
    /// Returns the corresponding image from the assets
    /// - Parameter imageResource: The image resource
    /// - Returns: The image found from the assets
    static func image(_ imageResource: Style.Image) -> SwiftUI.Image {
        return SwiftUI.Image(imageResource.rawValue)
    }
}
