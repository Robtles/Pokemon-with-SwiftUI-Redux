//
//  PokemonStat.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation
import SwiftUI

// MARK: - Pokemon Stats
/// Lists the stats to display for each Pokemon
enum PokemonStat: String, Codable {
    // MARK: Static Properties
    static let sorted: [PokemonStat] = [.healthPoints, .attack, .defense, .specialAttack, .specialDefense, .speed]
    
    // MARK: Cases
    case attack = "attack"
    case defense = "defense"
    case healthPoints = "hp"
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"
    
    // MARK: Computed Properties
    var backgroundColor: Color {
        switch self {
        case .attack:
            return Color(hexColor: "#FF994D")
        case .defense:
            return Color(hexColor: "#EECD3D")
        case .healthPoints:
            return Color(hexColor: "#DF2140")
        case .specialAttack:
            return Color(hexColor: "#85DDFF")
        case .specialDefense:
            return Color(hexColor: "#96DA83")
        case .speed:
            return Color(hexColor: "#FB94A8")
        }
    }
    
    var name: String {
        switch self {
        case .attack:
            return "ATK"
        case .defense:
            return "DEF"
        case .healthPoints:
            return "HP"
        case .specialAttack:
            return "SpA"
        case .specialDefense:
            return "SpD"
        case .speed:
            return "SPD"
        }
    }
}
