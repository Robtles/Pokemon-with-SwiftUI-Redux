//
//  Modal.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 18/05/2022.
//

import SwiftUI

// MARK: - Modal
/// This should enumerate all the possible modals of the app,
/// and their corresponding view.
enum Modal {
    // MARK: Cases
    case pokemonView(pokemonId: Binding<Int?>)
    
    // MARK: View Properties
    func body(visibilityParameter: Binding<Bool>) -> some View {
        switch self {
        case .pokemonView(let pokemonId):
            return PokemonView(
                pokemonId: pokemonId,
                showing: visibilityParameter
            )
        }
    }
}
