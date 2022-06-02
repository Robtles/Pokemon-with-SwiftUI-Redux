//
//  PokemonAPIError.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon API Errors
/// Contains several Pokemon API errors
enum PokemonAPIError: Error, CustomStringConvertible {
    // MARK: Cases
    /// The error to throw when encountering a bad status code
    case badStatusCode(Int)
    /// JSON content decoding failed
    case contentDecodingFailed
    /// Missing Pokemon evolution chain id for API call
    case missingPokemonEvolutionChainId
    
    // MARK: Computed Properties
    var description: String {
        switch self {
        case .badStatusCode(let code):
            return "Bad status code: \(code)"
        case .contentDecodingFailed:
            return "Content decoding failed"
        case .missingPokemonEvolutionChainId:
            return "Missing Pokemon evolution chain id for API call"
        }
    }
}
