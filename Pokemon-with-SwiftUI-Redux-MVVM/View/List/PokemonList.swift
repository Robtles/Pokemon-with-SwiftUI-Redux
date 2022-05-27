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
        let typed = typedText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        return typedText.isEmpty ?
            pokemonCoordinator.pokemons :
        pokemonCoordinator.pokemons.filter {
            ($0.name?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
                .contains(typed)
        }
    }
    
    // MARK: Instance Properties
    /// The Pokemons container
    @EnvironmentObject var pokemonCoordinator: PokemonCoordinator
    
    /// If the list should present a `Pokemon`
    @State private var isPresentingPokemon: Bool = false
    /// If the view is in a loading state
    @State private var loading: Bool = false
    /// The selected Pokemon id
    @State private var pokemonId: Int?
    /// Variable tracking the focus state of the text field
    @FocusState private var textFieldIsFocused: Bool
    /// The text typed in the text field
    @State private var typedText: String = ""

    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .top) {
            Style.Color.listBackground
                .ignoresSafeArea()
            VStack(spacing: 0) {
                CustomTextField(
                    placeholderText: "Type a Pokemon name...",
                    text: $typedText
                )
                .focused($textFieldIsFocused)
                .padding(.horizontal, 16.0)
                .padding(.top, 16.0)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .onAppear {
            pokemonCoordinator.loadAllPokemons {
                loading = false
            }
        }
        // The loading overview
        .modifier(PokemonListLoadingView(loading: $loading))
        // The Pokemon modal
        .showModal(.pokemonView(pokemonId: $pokemonId), if: $isPresentingPokemon)
        // Tap everywhere to dismiss keyboard
        .onTapGesture {
            textFieldIsFocused = false
        }
    }
    
    // MARK: View Methods
    /// It both presents this `Pokemon` sheet and fetches its additional information.
    /// Note that I wanted to do it in `PokemonView.onAppear {}` first but it often
    /// led to unexpected behaviours (i.e. this not being called)
    /// - Parameter id: The Pokemon `id`
    private func presentAndFetchInformationOfPokemonWithId(_ id: Int) {
        textFieldIsFocused = false
        isPresentingPokemon = true
        pokemonId = id
        pokemonCoordinator.load(pokemonWithId: id)
    }
}

#if DEBUG
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
            .environmentObject(PokemonCoordinator([
                pokemonSimpleSampleBulbasaur,
                pokemonFullSampleCaterpie
            ]))
    }
}
#endif
