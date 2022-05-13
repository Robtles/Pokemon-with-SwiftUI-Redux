//
//  PokemonEvolution.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon Evolution Chain
/// Describes a first generation Pokemon evolution chain
/// with the initial Pokemon in the chain and all its futher evolutions
struct PokemonEvolutionChain {
    /// The initial Pokemon in the evolution chain
    let initialPokemon: (id: Int?, name: String?)
    /// The Pokemons that come after in this chain
    let evolutions: [PokemonEvolution]
}

// MARK: - Pokemon Evolution
/// Describes a Pokemon chain of eventual evolutions
struct PokemonEvolution {
    // MARK: Properties
    /// The Pokemon base information - id and name
    let information: (id: Int, name: String)
    /// The evolution type
    let type: PokemonEvolutionType
    /// This evolution possible evolutions
    let evolutions: [PokemonEvolution]
    
    // MARK: Init Methods
    private init(
        information: (id: Int, name: String),
        type: PokemonEvolutionType,
        evolutions: [PokemonEvolution]
    ) {
        self.information = information
        self.type = type
        self.evolutions = evolutions
    }
    
    /// Tries to create a `PokemonEvolution` object from a JSON evolution result chunk
    /// - Parameter evolvesTo: The JSON result chunk
    /// - Returns: The resulting `PokemonEvolution` (or nil if nothing found)
    static func from(_ evolvesTo: PokemonEvolutionChainResult) -> PokemonEvolution? {
        guard let id = evolvesTo.species.url.extractedIdFromUrl,
              id <= 151,
              let firstEvolutionDetails = evolvesTo.evolutionDetails.first,
              let type = PokemonEvolutionType.from(firstEvolutionDetails) else {
            return nil
        }
        return PokemonEvolution(
            information: (id: id, name: evolvesTo.species.name.capitalized),
            type: type,
            evolutions: evolvesTo.evolvesTo.compactMap {
                PokemonEvolution.from($0)
            }
        )
    }
}
