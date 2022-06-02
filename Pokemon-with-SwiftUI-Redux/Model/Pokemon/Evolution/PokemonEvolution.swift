//
//  PokemonEvolution.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation

// MARK: - Pokemon Evolution
/// Describes a Pokemon chain of eventual evolutions
struct PokemonEvolution {
    // MARK: Computed Properties
    func chain() -> [[PokemonEvolution]] {
        guard !evolutions.isEmpty,
                !evolutions.contains(where: { $0.information.id > Pokemon.limit }) else {
            return [[self]]
        }
        return evolutions
            .flatMap { $0.chain() }
            .map { [self] + $0 }
    }
    
    // MARK: Instance Properties
    /// The Pokemon base information - id and name
    let information: (id: Int, name: String)
    /// The evolution type
    let type: PokemonEvolutionType
    /// This evolution possible evolutions
    let evolutions: [PokemonEvolution]

    // MARK: Init Methods
    init(
        information: (id: Int, name: String),
        type: PokemonEvolutionType,
        evolutions: [PokemonEvolution]
    ) {
        self.information = information
        self.type = type
        self.evolutions = evolutions
    }
    
    // MARK: Static Methods
    /// Tries to create a `PokemonEvolution` object from a JSON evolution result chunk
    /// - Parameter evolvesTo: The JSON result chunk
    /// - Returns: The resulting `PokemonEvolution` (or nil if nothing found)
    static func from(_ evolvesTo: PokemonEvolutionChainResult) -> PokemonEvolution? {
        guard let id = evolvesTo.species.url.extractedIdFromUrl,
              let firstEvolutionDetails = evolvesTo.evolutionDetails.first(where: { $0.isValid }),
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

extension Array where Element == PokemonEvolution {
    var id: String {
        compactMap { "\($0.information.id)" }.joined()
    }
}
