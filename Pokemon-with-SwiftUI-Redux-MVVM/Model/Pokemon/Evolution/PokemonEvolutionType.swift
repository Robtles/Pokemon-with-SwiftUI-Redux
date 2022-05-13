//
//  PokemonEvolutionType.swift
//  FinalTestAPI
//
//  Created by Rob on 13/05/2022.
//

import Foundation

// MARK: - Pokemon Evolution Type
/// Describes how the Pokemon evolves
enum PokemonEvolutionType {
    // MARK: Cases
    /// If the Pokemon evolves with an item (associating the item name)
    case item(PokemonEvolutionItem)
    /// If the Pokemon evolves when reaching a given level
    case level(Int?)
    /// If the Pokemon evolves when being traded
    case trade
    
    // MARK: Static Methods
    /// Tries to initialize a `PokemonEvolutionType` from the decoded JSON result
    /// - Parameter evolvesTo: The decoded JSON result chunk
    /// - Returns: The resulting `PokemonEvolutionType` (or nil if nothing found)
    static func from(_ evolutionDetailsResult: PokemonEvolutionDetailsResult) -> PokemonEvolutionType? {
        if let item = PokemonEvolutionItem(evolutionDetailsResult.item?.name) {
            return .item(item)
        }
        switch PokemonEvolutionTypeTrigger(evolutionDetailsResult.trigger?.name) {
        case .levelUp:
            return .level(evolutionDetailsResult.minLevel)
        case .trade:
            return .trade
        default:
            return nil
        }
    }
}

// MARK: - Pokemon Evolution Type Trigger
enum PokemonEvolutionTypeTrigger: String {
    // MARK: Cases
    case levelUp = "level-up"
    case trade = "trade"
    
    // MARK: Init Methods
    init?(_ rawValue: String?) {
        guard let rawValue = rawValue,
              let pokemonEvolutionTypeTrigger = PokemonEvolutionTypeTrigger(rawValue: rawValue) else {
            return nil
        }
        self = pokemonEvolutionTypeTrigger
    }
}
