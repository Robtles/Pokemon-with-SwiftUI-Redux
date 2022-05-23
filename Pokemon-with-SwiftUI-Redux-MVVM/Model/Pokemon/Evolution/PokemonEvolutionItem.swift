//
//  PokemonEvolutionItem.swift
//  FinalTestAPI
//
//  Created by Rob on 13/05/2022.
//

import Foundation

// MARK: - Pokemon Evolution Item
/// Describes an item that allows some Pokemon to evolve
enum PokemonEvolutionItem: String {
    // MARK: Cases
    case fireStone = "fire-stone"
    case leafStone = "leaf-stone"
    case moonStone = "moon-stone"
    case thunderStone = "thunder-stone"
    case waterStone = "water-stone"
    
    // MARK: Computed Properties
    /// The text to display for this item
    var text: String {
        switch self {
        case .fireStone:
            return "Fire Stone"
        case .leafStone:
            return "Leaf Stone"
        case .moonStone:
            return "Moon Stone"
        case .thunderStone:
            return "Thunder Stone"
        case .waterStone:
            return "Water Stone"
        }
    }
    
    // MARK: Init Methods
    init?(_ rawValue: String?) {
        guard let rawValue = rawValue,
              let pokemonEvolutionItem = PokemonEvolutionItem(rawValue: rawValue) else {
            return nil
        }
        self = pokemonEvolutionItem
    }
}
