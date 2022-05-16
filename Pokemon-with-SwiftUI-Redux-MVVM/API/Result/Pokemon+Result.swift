//
//  Pokemon+Result.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 16/05/2022.
//

import Foundation

// MARK: - Pokemon Generic Information Result
struct PokemonInformationResult: Codable {
    /// The name of the Pokemon
    let name: String
    /// The URL of the Pokemon
    let url: String
}
