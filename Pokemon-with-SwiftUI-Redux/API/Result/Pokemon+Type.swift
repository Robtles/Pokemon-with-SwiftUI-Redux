//
//  Pokemon+Types.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 16/05/2022.
//

import Foundation

// MARK: - Pokemon Type Result
struct PokemonTypeResult: Codable {
    // MARK: Properties
    /// Contains the Pokemon's type name
    let name: String
    /// A list of Pokemons of this type
    let pokemon: [PokemonTypePokemonResult]
}

// MARK: - Pokemon Type Pokemon Result
struct PokemonTypePokemonResult: Codable {
    /// The Pokemon information
    let pokemon: PokemonInformationResult
    /// The type order
    let slot: Int
}
