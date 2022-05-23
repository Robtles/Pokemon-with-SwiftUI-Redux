//
//  PokemonEvolutionType.swift
//  FinalTestAPI
//
//  Created by Rob on 13/05/2022.
//

import Foundation
import SwiftUI

// MARK: - Pokemon Evolution Type
/// Describes how the Pokemon evolves
enum PokemonEvolutionType {
    // MARK: Cases
    /// If this Pokemon evolves with a needed amount of happiness
    case happiness(Int)
    /// If this is the initial Pokemon in the evolution chain
    case initial
    /// If the Pokemon evolves with an item (associating the item name)
    case item(PokemonEvolutionItem)
    /// If the Pokemon evolves when reaching a given level
    case level(Int?)
    /// If the Pokemon evolves when being traded
    case trade
    
    // MARK: Computed Properties
    /// The text to display for this type
    var text: String {
        switch self {
        case .happiness:
            return "😄"
        case .item(let pokemonEvolutionItem):
            return pokemonEvolutionItem.text
        case .level(let value):
            guard let value = value else {
                return "Lvl ?"
            }
            return "Lvl \(value)"
        case .trade:
            return "Trade"
        default:
            return ""
        }
    }
    
    // MARK: View Properties
    var view: AnyView {
        switch self {
        case .initial:
            return AnyView(EmptyView())
        default:
            return AnyView(HStack(spacing: 0) {
                ZStack {
                    Style.Color.listBackground
                        .frame(width: 50, height: 32)
                        .cornerRadius(30.0)
                    Text(text)
                        .multilineTextAlignment(.center)
                        .font(Style.Font.bold(sized: 12.0))
                        .foregroundColor(Style.Color.blackText)
                        .lineLimit(2)
                }
                .frame(width: 50.0)
                .padding(.trailing, 12)
                .padding(.leading, 4)
            })
        }
    }
    
    // MARK: Static Methods
    /// Tries to initialize a `PokemonEvolutionType` from the decoded JSON result
    /// - Parameter evolvesTo: The decoded JSON result chunk
    /// - Returns: The resulting `PokemonEvolutionType` (or nil if nothing found)
    static func from(_ evolutionDetailsResult: PokemonEvolutionDetailsResult) -> PokemonEvolutionType? {
        if let happiness = evolutionDetailsResult.minHappiness {
            return .happiness(happiness)
        }
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
