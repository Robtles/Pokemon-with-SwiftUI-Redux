//
//  PokemonState.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 01/06/2022.
//

import Foundation
import SwiftUIFlux

// MARK: - App State
/// The state related to Pokemon information throughout the app
struct PokemonState: FluxState {
    // MARK: Instance Properties
    /// The loading state for each Pokemon
    /// `i.e. [25: [.species: true]] means that species data is fetched for Pokemon with id 25`
    var loadingState: [Int: [LoadState: Bool]] = [:]
    /// The Pokemon list
    var pokemons: [Pokemon] = []
    
    // MARK: Init Methods
    /// Default init
    init() {
        loadingState = [:]
        pokemons = []
    }
    
    #if DEBUG
    /// Initializes the PokemonState with some debug data
    /// - Parameters:
    ///   - loadingState: The loading state
    ///   - pokemons: The Pokemon data
    init(loadingState: [Int: [LoadState: Bool]], pokemons: [Pokemon]) {
        self.loadingState = loadingState
        self.pokemons = pokemons
    }
    #endif
}
