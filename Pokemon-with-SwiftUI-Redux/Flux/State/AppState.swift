//
//  AppState.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 01/06/2022.
//

import Foundation
import SwiftUIFlux

// MARK: - App State
/// The main app state
struct AppState: FluxState {
    // MARK: Instance Properties
    /// The Pokemon related state
    var pokemonState: PokemonState = PokemonState()
}
