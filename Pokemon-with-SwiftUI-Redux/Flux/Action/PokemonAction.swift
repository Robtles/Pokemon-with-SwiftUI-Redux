//
//  PokemonAction.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 02/06/2022.
//

import Foundation
import SwiftUIFlux

// MARK: - Pokemon-related actions
enum PokemonAction: Action {
    // MARK: Cases
    /// Fills information for a specific Pokemon
    case fill(LoadState?, Pokemon)
    /// Fills all the Pokemon fetched from a global API request
    case fillAll([Pokemon])
}
