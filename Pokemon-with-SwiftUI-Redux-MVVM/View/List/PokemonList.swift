//
//  PokemonList.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 13/05/2022.
//

import SwiftUI

// MARK: - Pokemon List View
/// This component represents the Pokedex (list of Pokemon)
struct PokemonList: View {
    // MARK: Static Properties
    /// The amount of elements to display per line
    static let elementsPerLine: Int = 2
    
    static var preference = (0..<PokemonList.elementsPerLine)
        .map { _ in GridItem(.flexible()) }
    
    // MARK: Computed Properties
    private var pokemons: [Pokemon] {
        pokemonContainer.pokemons
    }
    
    // MARK: Instance Properties
    /// Contains all the `Pokemon` and will broadcast any info update
    @StateObject var pokemonContainer = PokemonContainer()
    
    /// If the list should present a `Pokemon`
    @State private var isPresentingPokemon: Bool = false
    /// If the view is in a loading state
    @State private var loading: Bool = true
    /// The id of the tapped `Pokemon` to show
    @State private var pokemonShownId: Int?

    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .top) {
            Style.Color.listBackground
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: PokemonList.preference) {
                    ForEach(pokemons.dropLast(pokemons.count % PokemonList.elementsPerLine), id: \.id) { pokemon in
                        PokemonListRow(pokemon: pokemon)
                            .onTapGesture {
                                presentAndFetchInformationOfPokemonWithId(pokemon.id)
                            }
                    }
                }
                LazyHStack {
                    ForEach(pokemons.suffix(pokemons.count % PokemonList.elementsPerLine), id: \.id) { pokemon in
                        PokemonListRow(pokemon: pokemon)
                            .onTapGesture {
                                presentAndFetchInformationOfPokemonWithId(pokemon.id)
                            }
                    }
                }
            }
            .padding(.horizontal, 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                PokemonService.fetchAllPokemons { result in
                    switch result {
                    case .success(let pokemonResult):
                        pokemonContainer.pokemons = pokemonResult
                        loading = false
                    case .failure:
                        break
                    }
                }
            }
        }
        // The loading overview
        .modifier(LoadingView(loading: $loading))
        // The Pokemon modal
        .showModal(.pokemonView(pokemonId: pokemonShownId), if: $isPresentingPokemon)
        // Passing the container to the next views in hierarchy
        .environmentObject(pokemonContainer)
    }
    
    // MARK: View Methods
    /// It both presents this `Pokemon` sheet and fetches its additional information.
    /// Note that I wanted to do it in `PokemonView.onAppear {}` first but it often
    /// led to unexpected behaviours (i.e. this not being called)
    /// - Parameter id: The Pokemon Kanto `id`
    private func presentAndFetchInformationOfPokemonWithId(_ id: Int) {
        pokemonShownId = id
        isPresentingPokemon = true
        PokemonService.fetch(pokemonWithId: id) { pokemon in
            if let pokemonIndex = pokemonContainer.pokemons.firstIndex(where: { $0.id == id }) {
                pokemonContainer.pokemons[pokemonIndex] = pokemon
            }
        }
    }
}

#if DEBUG
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
            .environmentObject(PokemonContainer([
                pokemonSimpleSampleBulbasaur,
                pokemonFullSampleCaterpie
            ]))
    }
}
#endif
