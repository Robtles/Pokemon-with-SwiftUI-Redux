//
//  PokemonAsyncAction.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 01/06/2022.
//

import Foundation
import SwiftUIFlux

// MARK: - Pokemon-related asynchronous actions
enum PokemonAsyncAction: AsyncAction {
    // MARK: Cases
    /// Loads all the Pokemons
    case loadAll(_ completion: () -> Void)
    /// Loads information for a specific Pokemon
    case load(pokemonId: Int)
    
    // MARK: Methods
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
        switch self {
        case .loadAll(let completion):
            PokemonService.fetchAllPokemons { result in
                completion()
                switch result {
                case .success(let pokemonResult):
                    dispatch(PokemonAction.fillAll(pokemonResult))
                default:
                    break // But we could display a loading error here
                }
            }
        case .load(let pokemonId):
            PokemonService.fetch(pokemonWithId: pokemonId) { loadState, pokemon in
                dispatch(PokemonAction.fill(loadState, pokemon))
            }
        }
    }
}
