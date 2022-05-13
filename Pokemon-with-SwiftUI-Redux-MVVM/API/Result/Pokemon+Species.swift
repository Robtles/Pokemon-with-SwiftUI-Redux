//
//  Pokemon+Species.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon Species Result
struct PokemonSpeciesResult: Codable {
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
    }
    
    // MARK: Properties
    /// Contains the Pokemon evolution chain's URL
    let evolutionChain: PokemonSpeciesEvolutionChainResult
    /// A list of flavor text entries for this Pokemon species
    let flavorTextEntries: [PokemonSpeciesFlavorTextEntryResult]
}

// MARK: - Pokemon Species Evolution Chain Result
struct PokemonSpeciesEvolutionChainResult: Codable {
    // MARK: Properties
    /// The Pokemon evolution chain URL
    let url: String
}

// MARK: - Pokemon Species Flavor Text Entry Result
struct PokemonSpeciesFlavorTextEntryResult: Codable {
    // MARK: - Inner Types
    // MARK: Pokemon Species Flavor Text Entry Language Result
    struct LanguageResult: Codable {
        // MARK: Properties
        /// The language name
        let name: String
    }

    // MARK: Pokemon Species Flavor Text Entry Version Result
    struct VersionResult: Codable {
        // MARK: Properties
        /// The version name
        let name: String
    }
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language = "language"
        case version = "version"
    }
    
    // MARK: Properties
    /// This Pokemon localized flavor text in a specific language and game version
    let flavorText: String
    /// The language
    let language: LanguageResult
    /// The version
    let version: VersionResult
}
