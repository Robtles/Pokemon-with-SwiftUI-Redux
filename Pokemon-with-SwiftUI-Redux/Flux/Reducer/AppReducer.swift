//
//  AppReducer.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 01/06/2022.
//

import Foundation
import SwiftUIFlux

// MARK: - App Reducer
/// The main app reducer - all logic transits in this component first
func appReducer(state: AppState?, action: Action) -> AppState {
    var state = state ?? AppState()
    state.pokemonState = pokemonReducer(state: state.pokemonState, action: action)
    return state
}
