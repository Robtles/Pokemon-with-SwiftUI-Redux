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
    
    // MARK: Instance Properties
    @State private var loading: Bool = true
    @State private var pokemons: [Pokemon] = []
    
    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .top) {
            Style.Color.listBackground
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: PokemonList.preference) {
                    ForEach(pokemons.dropLast(pokemons.count % PokemonList.elementsPerLine), id: \.id) { pokemon in
                        PokemonListRow(pokemon: pokemon)
                    }
                }
                LazyHStack {
                    ForEach(pokemons.suffix(pokemons.count % PokemonList.elementsPerLine), id: \.id) { pokemon in
                        PokemonListRow(pokemon: pokemon)
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
                        pokemons = pokemonResult
                        loading = false
                    case .failure:
                        break
                    }
                }
            }
        }
        .modifier(LoadingView(loading: $loading))
    }
    
    // MARK: Init Methods
    init(_ pokemons: [Pokemon] = []) {
        self._pokemons = State(initialValue: pokemons)
    }
}

#if DEBUG
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList([
            pokemonSampleBulbasaur,
            pokemonSamplePikachu
        ])
    }
}
#endif
