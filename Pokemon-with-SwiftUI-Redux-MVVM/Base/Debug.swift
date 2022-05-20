//
//  Debug.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 15/05/2022.
//

import Foundation
import SwiftUI

#if DEBUG
// Simple Pokemons (for list purposes)
let pokemonSimpleSampleBulbasaur = Pokemon(id: 1, name: "Bulbasaur", types: [.grass, .poison])
let pokemonSimpleSampleIvysaur = Pokemon(id: 2, name: "Ivysaur", types: [.grass, .poison])
let pokemonSimpleSampleVenusaur = Pokemon(id: 3, name: "Venusaur", types: [.grass, .poison])
let pokemonSimpleSamplePikachu = Pokemon(id: 25, name: "Pikachu", types: [.electric])

// Full Pokemon (for view purposes)
var pokemonFullSampleCaterpie: Pokemon {
    let pokemon = Pokemon(id: 10, name: "Caterpie", types: [.bug])
    pokemon.description = "When several of these pokémon gather,\n" +
        "their electricity could build and cause lightning storms."
    pokemon.height = 0.3
    pokemon.weight = 2.9
    pokemon.abilities = ["Shield Dust", "Run Away"]
    pokemon.stats = [
        .healthPoints: 30,
        .attack: 45,
        .defense: 35,
        .specialAttack: 20,
        .specialDefense: 20,
        .speed: 45
    ]
    pokemon.evolutionChain = PokemonEvolutionChain(
        initialPokemon: (id: 10, name: "Caterpie"),
        evolutions: [
            PokemonEvolution(
                information: (id: 11, name: "Metapod"),
                type: .level(7),
                evolutions: [
                    PokemonEvolution(
                        information: (id: 12, name: "Butterfree"),
                        type: .level(10),
                        evolutions: []
                    )
                ]
            )
        ]
    )
    return pokemon
}

var pokemonFullSampleEevee: Pokemon {
    let pokemon = Pokemon(id: 133, name: "Eevee", types: [.normal])
    pokemon.description = "Its genetic code is irregular.\n" +
        "It may mutate if it is exposed to radiation from element stones."
    pokemon.height = 0.3
    pokemon.weight = 6.5
    pokemon.abilities = ["Run Away", "Adaptability"]
    pokemon.stats = [
        .healthPoints: 55,
        .attack: 55,
        .defense: 50,
        .specialAttack: 45,
        .specialDefense: 65,
        .speed: 55
    ]
    pokemon.evolutionChain = PokemonEvolutionChain(
        initialPokemon: (id: 133, name: "Eevee"),
        evolutions: [
            PokemonEvolution(
                information: (id: 134, name: "Vaporeon"),
                type: .item(.waterStone),
                evolutions: []
            ),
            PokemonEvolution(
                information: (id: 135, name: "Jolteon"),
                type: .item(.thunderStone),
                evolutions: []
            ),
            PokemonEvolution(
                information: (id: 136, name: "Flareon"),
                type: .item(.fireStone),
                evolutions: []
            )
        ]
    )
    return pokemon
}

var samplePokemonContainer = PokemonContainer([
    pokemonSimpleSampleBulbasaur,
    pokemonFullSampleCaterpie,
    pokemonFullSampleEevee
])
#endif
