//
//  Pokemon.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon
/// Represents a Pokemon
class Pokemon: Identifiable, Hashable {
    // MARK: Static Properties
    /// Limit of the accepted Pokemon ids, to avoid strange forms
    static let limit = 898
    
    // MARK: Computed Properties
    var listImageStringURL: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
    var sortedTypes: [PokemonType] {
        var result: [PokemonType] = []
        if let firstType = types.0 {
            result.append(firstType)
        }
        if let secondType = types.1 {
            result.append(secondType)
        }
        return result
    }
    
    var viewImageStringURL: String {        
        return "https://raw.githubusercontent.com/" +
            "PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/\(id).gif"
    }
    
    // MARK: Instance Properties
    /// A list of the potential Pokemon abilities
    var abilities: [String]?
    /// This Pokemon English species description
    var description: String?
    /// The Pokemon chain of evolutions
    var evolution: PokemonEvolution?
    /// The Pokemon height in decimeters
    var height: Double?
    /// The Pokemon Pokedex's id
    let id: Int
    /// The Pokemon English name
    var name: String?
    /// The base stats list for this Pokemon
    var stats: [PokemonStat: Int]?
    /// The Pokemon types
    var types: (PokemonType?, PokemonType?) = (nil, nil)
    /// The Pokemon weight in hectograms
    var weight: Double?
    
    // MARK: Init Methods
    /// Initializes a Pokemon from its id
    /// - Parameter id: The Pokemon index in the Pokedex
    init(_ id: Int) {
        self.id = id
    }
    
    init(id: Int, name: String, types: [PokemonType]) {
        self.id = id
        self.name = name
        types.enumerated().forEach { set(type: $0.element, at: $0.offset) }
    }
    
    // MARK: Setter Methods
    /// Sets a given type at a given slot
    /// - Parameters:
    ///   - type: The type to set
    ///   - index: The type slot
    func set(type: PokemonType, at index: Int) {
        switch index {
        case 0:
            types.0 = type
        case 1:
            types.1 = type
        default:
            return
        }
    }
    
    // MARK: - Hashable
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A missing Pokemon sample if needed
let sampleMissingPokemon = Pokemon(
    id: 0,
    name: "No information",
    types: []
)
