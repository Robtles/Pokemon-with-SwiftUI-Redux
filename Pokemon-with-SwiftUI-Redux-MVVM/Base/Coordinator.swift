//
//  Coordinator.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 23/05/2022.
//

import Foundation

// MARK: - Pokemon Container
/// A observable coordinator that will be able
/// to dispatch any update to the views
class PokemonCoordinator: ObservableObject {
    // MARK: - Instance Properties
    /// The loading information for each Pokemon
    @Published var pokemonLoadingInformation: [Int: [LoadState: Bool]] = [:]
    /// The list of Pokemons
    @Published var pokemons: [Pokemon]
    
    // MARK: - Init Methods
    init(_ pokemons: [Pokemon] = []) {
        self.pokemons = pokemons
    }
    
    // MARK: - Methods
    /// Loads all the Pokemons from the API and adds a completion block
    func loadAllPokemons(_ completion: @escaping () -> Void) {
        PokemonService.fetchAllPokemons { result in
            completion()
            switch result {
            case .success(let pokemonResult):
                self.pokemonLoadingInformation = pokemonResult.map { $0.id }
                    .reduce(into: [:], { $0[$1] = [
                        .description: false,
                        .evolution: false,
                        .species: false
                    ] })
                self.pokemons = pokemonResult
            default:
                break
            }
        }
    }
    
    /// Loads a Pokemon with a specific id
    func load(pokemonWithId id: Int) {
        PokemonService.fetch(pokemonWithId: id) { loadState, pokemon in
            if let loadState = loadState {
                self.pokemonLoadingInformation[pokemon.id]?[loadState] = true
            }
            if let pokemonIndex = self.pokemons.firstIndex(where: { $0.id == id }) {
                self.pokemons[pokemonIndex] = pokemon
            } else {
                self.pokemons.append(pokemon)
                self.pokemons.sort(by: { $0.id < $1.id })
            }
        }
    }
}
