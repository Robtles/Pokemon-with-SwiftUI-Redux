//
//  Modal.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 18/05/2022.
//

import SwiftUI

// MARK: - Modal
/// This should enumerate all the possible modals of the app,
/// and their corresponding view.
enum Modal {
    // MARK: Cases
    case pokemonView
    
    // MARK: View Properties
    func body(visibilityParameter: Binding<Bool>) -> some View {
        switch self {
        case .pokemonView:
            return PokemonView(showing: visibilityParameter)
        }
    }
}
