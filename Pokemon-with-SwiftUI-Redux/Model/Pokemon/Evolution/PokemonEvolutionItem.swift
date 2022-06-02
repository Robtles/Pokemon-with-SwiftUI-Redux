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
    case dawnStone = "dawn-stone"
    case duskStone = "dusk-stone"
    case fireStone = "fire-stone"
    case leafStone = "leaf-stone"
    case moonStone = "moon-stone"
    case oddStone = "odd-stone"
    case shinyStone = "shiny-stone"
    case sunStone = "sun-stone"
    case thunderStone = "thunder-stone"
    case waterStone = "water-stone"
    
    // MARK: Computed Properties
    /// The text to display for this item
    var text: String {
        switch self {
        case .dawnStone:
            return "Dawn Stone"
        case .duskStone:
            return "Dusk Stone"
        case .fireStone:
            return "Fire Stone"
        case .leafStone:
            return "Leaf Stone"
        case .moonStone:
            return "Moon Stone"
        case .oddStone:
            return "Odd Stone"
        case .shinyStone:
            return "Shiny Stone"
        case .sunStone:
            return "Sun Stone"
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
