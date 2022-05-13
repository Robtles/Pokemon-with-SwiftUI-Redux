//
//  Pokemon.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon
/// Represents a Pokemon
class Pokemon {
    // MARK: Properties
    /// A list of the potential Pokemon abilities
    var abilities: [String]?
    /// This Pokemon English species description
    var description: String?
    /// The Pokemon chain of evolutions
    var evolutionChain: PokemonEvolutionChain?
    /// The Pokemon height in decimeters
    var height: Double?
    /// The Pokemon id (index Kanto's Pokedex)
    let id: Int
    /// The Pokemon English name
    var name: String?
    /// The base stats list for this Pokemon
    var stats: [PokemonStat: Int]?
    /// The Pokemon types
    var types: [PokemonType]?
    /// The Pokemon weight in hectograms
    var weight: Double?
    
    // MARK: Init Methods
    /// Initializes a Pokemon from its id
    /// - Parameter id: The Pokemon index in Kanto's Pokedex
    init(_ id: Int) {
        self.id = id
    }
}
