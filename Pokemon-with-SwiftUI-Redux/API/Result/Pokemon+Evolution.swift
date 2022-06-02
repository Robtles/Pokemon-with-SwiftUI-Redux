//
//  Pokemon+Evolution.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon Evolution Result
struct PokemonEvolutionResult: Codable {
    // MARK: Properties
    /// The base chain link. Contains recursive chain evolutions
    let chain: PokemonEvolutionChainResult
}

// MARK: - Pokemon Evolution Chain Result
struct PokemonEvolutionChainResult: Codable {
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case species = "species"
    }
    
    // MARK: Properties
    /// All details regarding the specific details of the referenced Pokemon species evolution
    let evolutionDetails: [PokemonEvolutionDetailsResult]
    /// A list of chain links
    let evolvesTo: [PokemonEvolutionChainResult]
    /// The Pokemon species at this point in the evolution chain
    let species: PokemonInformationResult
}

// MARK: - Pokemon Evolution Details Result
struct PokemonEvolutionDetailsResult: Codable {
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case item = "item"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case trigger = "trigger"
    }
    
    // MARK: Properties
    /// The item that is required for the Pokemon to evolve
    var item: PokemonEvolutionDetailsItemResult?
    /// If this Pokemon evolves with a minimum level of happiness
    var minHappiness: Int?
    /// The minimum required level of the evolving Pokemon species to evolve into this Pokemon species
    var minLevel: Int?
    /// The type of event that triggers evolution into this Pokemon species
    var trigger: PokemonEvolutionDetailsTriggerResult?
    
    // MARK: Computed Properties
    /// Tells if this evolution chain should be displayed in the Pokemon's view
    var isValid: Bool {
        switch PokemonEvolutionTypeTrigger(trigger?.name) {
        case .levelUp:
            return minLevel != nil || minHappiness != nil
        case .trade:
            return true
        case .useItem:
            return PokemonEvolutionItem(item?.name) != nil
        default:
            return false
        }
    }
}

// MARK: - Pokemon Evolution Details Item Result
struct PokemonEvolutionDetailsItemResult: Codable {
    // MARK: Properties
    /// The name of the item that is required for the Pokemon to evolve
    let name: String
}

// MARK: - Pokemon Evolution Details Trigger Result
struct PokemonEvolutionDetailsTriggerResult: Codable {
    // MARK: Properties
    /// The evolution trigger name
    let name: String
}
