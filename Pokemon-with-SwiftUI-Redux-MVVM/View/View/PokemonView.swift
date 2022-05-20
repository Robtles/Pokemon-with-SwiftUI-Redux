//
//  PokemonView.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 17/05/2022.
//

import SwiftUI

// MARK: - Pokemon View
/// Describes a view containing all the information of a given `Pokemon`
struct PokemonView: View {
    // MARK: Instance Properties
    /// The passed `Pokemon` container
    @EnvironmentObject var pokemonContainer: PokemonContainer
    
    /// The id of the `Pokemon` to display
    var pokemonId: Int?
    
    // MARK: Computed Properties
    /// A simpler access to the Pokemon shown in this view
    private var pokemon: Pokemon? {
        pokemonContainer.pokemons.first(where: { $0.id == pokemonId })
    }
    
    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .center) {
            Color.white
                .padding(.top, 150)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text(pokemon?.name ?? "-")
                    .foregroundColor(.black)
                Text(pokemon?.abilities?.joined(separator: "\n") ?? "-")
                    .foregroundColor(.black)
            }
        }
    }
}

#if DEBUG
struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemonId: pokemonSimpleSampleBulbasaur.id)
            .environmentObject(samplePokemonContainer)
        PokemonView(pokemonId: pokemonFullSampleCaterpie.id)
            .environmentObject(samplePokemonContainer)
        PokemonView(pokemonId: pokemonFullSampleEevee.id)
            .environmentObject(samplePokemonContainer)
    }
}
#endif
