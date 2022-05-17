//
//  PokemonType.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation
import SwiftUI

// MARK: - Pokemon Types
/// The Pokemon types list
enum PokemonType: String, Codable, CaseIterable {
    // MARK: Cases
    case bug
    case dark
    case dragon
    case electric
    case fighting
    case fairy
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case shadow
    case steel
    case unknown
    case water
    
    // MARK: Computed Properties
    /// The badge background color
    var backgroundColor: Color {
        return Color(hexColor: backgroundColorHexValue)
    }
    
    /// The badge text's color
    var foregroundColor: Color {
        switch self {
        case .dark, .dragon, .fighting, .fire, .flying, .ghost, .poison, .psychic, .shadow, .water:
            return .white
        default:
            return .black
        }
    }
  
    /// The type name
    var name: String {
        return rawValue.capitalized
    }
    
    // MARK: Internal Properties
    /// The hexadecimal value for thistype's badge background color
    private var backgroundColorHexValue: String {
        switch self {
        case .normal:
            return "BCBCAC"
        case .fighting:
            return "BC5442"
        case .flying:
            return "669AFF"
        case .poison:
            return "AB549A"
        case .ground:
            return "DEBC54"
        case .rock:
            return "BCAC66"
        case .bug:
            return "ABBC1C"
        case .ghost:
            return "6666BC"
        case .steel:
            return "BCBCBC"
        case .fire:
            return "FF421C"
        case .water:
            return "2F9AFF"
        case .grass:
            return "78CD54"
        case .electric:
            return "FFCD30"
        case .psychic:
            return "FF549A"
        case .ice:
            return "78DEFF"
        case .dragon:
            return "7866EF"
        case .dark:
            return "785442"
        case .fairy:
            return "FFACFF"
        case .shadow:
            return "0E2E4C"
        case .unknown:
            return "DFDFDF"
        }
    }
}
