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
    /// The id of the `Pokemon` to display in the Pokemon view
//    @Published var pokemonId: Int?
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
            case .success(let pokemons):
                self.pokemons = pokemons
            default:
                break
            }
        }
    }
    
    /// Loads a Pokemon with a specific id
    func load(pokemonWithId id: Int) {
        PokemonService.fetch(pokemonWithId: id) { pokemon in
            if let pokemonIndex = self.pokemons.firstIndex(where: { $0.id == id }) {
                self.pokemons[pokemonIndex] = pokemon
            } else {
                self.pokemons.append(pokemon)
                self.pokemons.sort(by: { $0.id < $1.id })
            }
        }
    }
}
