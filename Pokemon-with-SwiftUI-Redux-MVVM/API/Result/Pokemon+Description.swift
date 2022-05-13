//
//  Pokemon+Description.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon Description Result
struct PokemonDescriptionResult: Codable {
    // MARK: Properties
    /// A list of the potential Pokemon abilities
    let abilities: [PokemonAbilityContainer]
    /// The Pokemon height in decimeters
    let height: Double
    /// The Pokemon English name
    let name: String
    /// The base stats list for this Pokemon
    let stats: [PokemonStatContainer]
    /// The Pokemon types
    let types: [PokemonTypeContainer]
    /// The Pokemon weight in hectograms
    let weight: Double
}

// MARK: - Pokemon Ability Container
struct PokemonAbilityContainer: Codable {
    // MARK: Properties
    /// The ability the Pokemon may have
    let ability: PokemonAbilityContainerInformation
    /// The abilities order
    let slot: Int
}

// MARK: - Pokemon Ability Container Information
struct PokemonAbilityContainerInformation: Codable {
    // MARK: Properties
    /// The ability name
    let name: String
}

// MARK: - Pokemon Type Container
struct PokemonTypeContainer: Codable {
    // MARK: Properties
    /// The Pokemon type
    let type: PokemonTypeContainerInformation
    /// The type order
    let slot: Int
}

// MARK: - Pokemon Type Container Information
struct PokemonTypeContainerInformation: Codable {
    // MARK: Properties
    /// The Pokemon type name
    let name: String
}

// MARK: - Pokemon Stat Container Information
struct PokemonStatContainer: Codable {
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case stat = "stat"
        case baseStat = "base_stat"
    }
    
    // MARK: Properties
    /// The Pokemon stat
    let stat: PokemonStatContainerInformation
    /// The value for this Pokemon stat
    let baseStat: Int
}

// MARK: - Pokemon Stat Container
struct PokemonStatContainerInformation: Codable {
    // MARK: Properties
    /// The Pokemon stat name
    let name: String
}
