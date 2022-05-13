//
//  PokemonStat.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

/// Lists the stats to display for each Pokemon
enum PokemonStat: String, Codable {
    case attack = "attack"
    case defense = "defense"
    case healthPoints = "hp"
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"
}
