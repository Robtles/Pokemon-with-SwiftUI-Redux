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
enum Modal: View {
    // MARK: Cases
    case pokemonView(pokemonId: Int?)
    
    // MARK: View Properties
    var body: some View {
        switch self {
        case .pokemonView(let pokemonId):
            return PokemonView(pokemonId: pokemonId)
        }
    }
}
