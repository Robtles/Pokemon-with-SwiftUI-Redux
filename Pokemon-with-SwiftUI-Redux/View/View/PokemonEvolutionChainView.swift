//
//  PokemonEvolutionChainView.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 20/05/2022.
//

import Kingfisher
import SwiftUI
import SwiftUIFlux

// MARK: - Pokemon Evolution Chain View
struct PokemonEvolutionChainView: ConnectedView {
    // MARK: Flux
    struct Props {
        let pokemon: Pokemon?
    }
    
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        return Props(
            pokemon: state.pokemonState.pokemons.first(where: { $0.id == pokemonId })
        )
    }

    // MARK: Instance Properties
    /// The id of the Pokemon currently displayed
    @Binding var pokemonId: Int?
    
    // MARK: View Properties
    func body(props: Props) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if (props.pokemon?.evolution?.evolutions ?? []).isEmpty {
                Text("No evolution for this Pokemon")
                    .font(Style.Font.regular(sized: 14.0))
                    .foregroundColor(Style.Color.grayText)
            } else {
                ForEach(props.pokemon?.evolution?.chain() ?? [], id: \.id) { evolutionChain in
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
                                    store.dispatch(action: PokemonAsyncAction.load(pokemonId: evolution.information.id))
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
                    .environmentObject(sampleStore(with: [pokemonFullSampleChansey]))
                PokemonEvolutionChainView(pokemonId: .constant(pokemonFullSampleCaterpie.id))
                    .environmentObject(sampleStore(with: [pokemonFullSampleCaterpie]))
                PokemonEvolutionChainView(pokemonId: .constant(pokemonFullSampleEevee.id))
                    .environmentObject(sampleStore(with: [pokemonFullSampleEevee]))
            }
        }
        .ignoresSafeArea()
    }
}
#endif
