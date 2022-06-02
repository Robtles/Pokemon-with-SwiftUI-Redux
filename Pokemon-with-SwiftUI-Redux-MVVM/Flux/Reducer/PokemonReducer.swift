//
//  PokemonReducer.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 01/06/2022.
//

import Foundation
import SwiftUIFlux

// MARK: - Pokemon Reducer
/// The Pokemon reducer - will contain all logic related to Pokemon data
func pokemonReducer(state: PokemonState?, action: Action) -> PokemonState {
    var state = state ?? PokemonState()
    switch action {
    case PokemonAction.fillAll(let pokemons):
        state.loadingState = pokemons.map { $0.id }
            .reduce(into: [:], { $0[$1] = [
                .description: false,
                .evolution: false,
                .species: false
            ] })
        state.pokemons = pokemons
    case PokemonAction.fill(let loadState, let pokemon):
        if let loadState = loadState {
            state.loadingState[pokemon.id]?[loadState] = true
        }
        if let pokemonIndex = state.pokemons.firstIndex(where: { $0.id == pokemon.id }) {
            pokemon.types = state.pokemons[pokemonIndex].types
            state.pokemons[pokemonIndex] = pokemon
        } else {
            state.pokemons.append(pokemon)
            state.pokemons.sort(by: { $0.id < $1.id })
        }
    default:
        break
    }
    return state
}
