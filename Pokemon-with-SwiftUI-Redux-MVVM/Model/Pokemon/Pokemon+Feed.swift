//
//  Pokemon+Feed.swift
//  FinalTestAPI
//
//  Created by Rob on 13/05/2022.
//

import Foundation

// MARK: - Pokemon Feeding Methods from API content
extension Pokemon {
    // MARK: Methods
    /// Feeds a `Pokemon` from a JSON decoded result
    /// - Parameter decodedInformation: The JSON decoded result
    func feed<T: Codable>(with decodedInformation: T) {
        switch decodedInformation {
        case let pokemonDescriptionResult as PokemonDescriptionResult:
            feedDescription(with: pokemonDescriptionResult)
        case let pokemonEvolutionResult as PokemonEvolutionResult:
            feedEvolution(with: pokemonEvolutionResult)
        case let pokemonSpeciesResult as PokemonSpeciesResult:
            feedSpecies(with: pokemonSpeciesResult)
        default:
            break
        }
    }
    
    /// Feeds a `Pokemon` types with the JSON information
    /// - Parameters:
    ///   - typeResult: The type information
    ///   - pokemonResult: The specific Pokemon information (the type slot for this species)
    func feedTypes(
        with typeResult: PokemonTypeResult,
        and pokemonResult: PokemonTypePokemonResult
    ) {
        guard let type = PokemonType(rawValue: typeResult.name) else {
            return
        }
        set(type: type, at: pokemonResult.slot - 1)
    }
    
    // MARK: Internal Methods
    /// Feeds the description of a `Pokemon` (abilities, types, height, stats, weight)
    /// - Parameter data: The `Pokemon`'s description information data
    private func feedDescription(with data: PokemonDescriptionResult) {
        self.abilities = Array(data.abilities
            .sorted(by: { $0.slot < $1.slot })
            .compactMap { $0.ability.name.replacingOccurrences(of: "-", with: " ").capitalized }
            .prefix(2))
        self.height = data.height / 10.0
        self.name = data.name.fixedName
        self.stats = data.stats.reduce(into: [:], {
            if let pokemonStat = PokemonStat(rawValue: $1.stat.name) {
                $0?[pokemonStat] = $1.baseStat
            }
        })
        self.weight = data.weight / 10.0
    }
    
    /// Feeds the evolution chain of a `Pokemon`
    /// - Parameter data: The `Pokemon`'s evolution information data
    private func feedEvolution(with data: PokemonEvolutionResult) {
        let evolutions = data.chain.evolvesTo.compactMap { PokemonEvolution.from($0) }
        if evolutions.first?.information.id == id {
            // In some cases, the evolution chain contains a baby Pokemon that was introduced in later generations
            // and comes before the Kanto's Pokemon in its chain (i.e. Pichu for Pikachu).
            self.evolutionChain = PokemonEvolutionChain(
                initialPokemon: (
                    id: data.chain.evolvesTo.first?.species.url.extractedIdFromUrl,
                    name: data.chain.evolvesTo.first?.species.name.capitalized
                ),
                evolutions: evolutions.first?.evolutions ?? []
            )
        } else {
            self.evolutionChain = PokemonEvolutionChain(
                initialPokemon: (
                    id: data.chain.species.url.extractedIdFromUrl,
                    name: data.chain.species.name.capitalized
                ),
                evolutions: evolutions
            )
        }
    }

    /// Feeds the species information of a `Pokemon` (contains its description and also the evolution chain id)
    /// - Parameter data: The `Pokemon`'s species information data
    private func feedSpecies(with data: PokemonSpeciesResult) {
        // Might be improved with an enum contain languages and versions later
        self.description = data.flavorTextEntries
            .first(where: { $0.language.name == "en" && $0.version.name == "blue" })?
            .flavorText
    }
}
