//
//  Pokemon+All.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon All Result
struct PokemonAllResult: Codable {
    // MARK: Properties
    let results: [PokemonAllResultResult]
}

// MARK: - Pokemon All Result SubResult
struct PokemonAllResultResult: Codable {
    // MARK: Properties
    /// The Pokemon English name
    let name: String
}
