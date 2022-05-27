//
//  PokemonEvolutionChainView.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 20/05/2022.
//

import Kingfisher
import SwiftUI

// MARK: - Pokemon Evolution Chain View
struct PokemonEvolutionChainView: View {
    // MARK: Computed Properties
    var pokemon: Pokemon? {
        pokemonCoordinator.pokemons.first(where: { $0.id == pokemonId })
    }
    
    // MARK: Instance Properties
    /// The passed `Pokemon` container
    @EnvironmentObject var pokemonCoordinator: PokemonCoordinator
    /// The id of the Pokemon currently displayed
    @Binding var pokemonId: Int?
    
    // MARK: View Properties
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if (pokemon?.evolution?.evolutions ?? []).isEmpty {
                Text("No evolution for this Pokemon")
                    .font(Style.Font.regular(sized: 14.0))
                    .foregroundColor(Style.Color.grayText)
            } else {
                ForEach(pokemon?.evolution?.chain() ?? [], id: \.id) { evolutionChain in
                    HStack(spacing: 0) {
                        ForEach(evolutionChain, id: \.information.id) { evolution in
                            HStack(spacing: 0) {
                                evolution.type.view
                                KFImage(URL(string: Pokemon(evolution.information.id).listImageStringURL))
                                    .frame(width: 62.0, height: 62.0)
                                    .padding(.trailing, 4)
                            }
                            .onTapGesture {
                                if evolution.information.id != pokemonId {
                                    pokemonId = evolution.information.id
                                    pokemonCoordinator.load(pokemonWithId: evolution.information.id)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
struct PokemonEvolutionChainView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            VStack(spacing: 24) {
                PokemonEvolutionChainView(pokemonId: .constant(pokemonFullSampleChansey.id))
                    .environmentObject(samplePokemonCoordinator)
                PokemonEvolutionChainView(pokemonId: .constant(pokemonFullSampleCaterpie.id))
                    .environmentObject(samplePokemonCoordinator)
                PokemonEvolutionChainView(pokemonId: .constant(pokemonFullSampleEevee.id))
                    .environmentObject(samplePokemonCoordinator)
            }
        }
        .ignoresSafeArea()
    }
}
#endif
