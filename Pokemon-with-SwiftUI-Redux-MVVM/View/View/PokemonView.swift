//
//  PokemonView.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 17/05/2022.
//

import Kingfisher
import SwiftUI

// MARK: - Pokemon View
/// Describes a view containing all the information of a given `Pokemon`
struct PokemonView: View {
    // MARK: Static Properties
    private static let buttonMargin: CGFloat = 16.0
    private static let topMargin: CGFloat = 50.0
    
    // MARK: Instance Properties
    /// The passed `Pokemon` container
    @EnvironmentObject var pokemonCoordinator: PokemonCoordinator
    /// The selected Pokemon id
    @Binding var pokemonId: Int?
    /// The variable that handles the view visibility
    @Binding var showing: Bool
    
    // MARK: Computed Properties
    /// A simpler access to the Pokemon shown in this view
    private var pokemon: Pokemon? {
        pokemonCoordinator.pokemons.first(where: { $0.id == pokemonId })
    }
    
    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.white
                    .cornerRadius(28.0, corners: [.topLeft, .topRight])
                    .ignoresSafeArea()
                HStack {
                    Spacer()
                    Button {
                        showing = false
                    } label: {
                        Style.image(.crossButton)
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                    }
                    .padding(.trailing, PokemonView.buttonMargin)
                }
                .padding(.top, PokemonView.buttonMargin)
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        VStack(spacing: 0) {
                            if let pokemonId = pokemon?.id {
                                Text("N° \(pokemonId)")
                                    .font(Style.Font.bold(sized: 12.0))
                                    .foregroundColor(Style.Color.grayText)
                            } else {
                                
                            }
                            if let pokemonName = pokemon?.name {
                                Text(pokemonName)
                                    .padding(.top, 6)
                                    .font(Style.Font.bold(sized: 24.0))
                                    .foregroundColor(Style.Color.blackText)
                            } else {
                                
                            }
                            if let pokemonTypes = pokemon?.sortedTypes {
                                PokemonTypeBadgeContainerView(pokemonTypes: pokemonTypes)
                                    .padding(.top, 8)
                            } else {
                                
                            }
                            Text("Pokedex entry")
                                .font(Style.Font.bold(sized: 16.0))
                                .padding(.top, 18)
                            Text(pokemon?.description ?? "")
                                .multilineTextAlignment(.center)
                                .font(Style.Font.regular(sized: 16.0))
                                .foregroundColor(Style.Color.grayText)
                                .padding(.top, 6)
                                .padding(.horizontal, 8)
                                .displayLoadingView(if: !loadingInformation(for: .species))
                            HStack {
                                Spacer()
                                Text("Height")
                                    .foregroundColor(Style.Color.blackText)
                                    .font(Style.Font.bold(sized: 16.0))
                                Spacer()
                                Spacer()
                                Text("Weight")
                                    .foregroundColor(Style.Color.blackText)
                                    .font(Style.Font.bold(sized: 16.0))
                                Spacer()
                            }
                            .padding(.top, 16)
                            HStack {
                                GrayBadgeView(text: "\(pokemon?.height ?? 0)m")
                                    .displayLoadingView(if: !loadingInformation(for: .description))
                                GrayBadgeView(text: "\(pokemon?.weight ?? 0)kg")
                                    .displayLoadingView(if: !loadingInformation(for: .description))
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.top, 8.0)
                            Text("Abilities")
                                .font(Style.Font.bold(sized: 16.0))
                                .padding(.top, 18)
                            HStack {
                                ForEach(pokemon?.abilities ?? [], id: \.self) {
                                    GrayBadgeView(text: $0)
                                }
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.top, 8.0)
                            .displayLoadingView(if: !loadingInformation(for: .description))
                        }
                        VStack(spacing: 0) {
                            Text("Stats")
                                .font(Style.Font.bold(sized: 16.0))
                                .padding(.top, 18)
                                .padding(.bottom, 12)
                            HStack {
                                ForEach(PokemonStat.sorted, id: \.rawValue) { stat in
                                    if let value = pokemon?.stats?[stat] {
                                        PokemonStatView(viewType: .stat(stat, value))
                                    }
                                }
                                PokemonStatView(viewType:
                                        .total((pokemon?.stats ?? [:])
                                            .mapValues { $0 }
                                            .reduce(0, { $0 + $1.value }))
                                )
                            }
                            .padding(.horizontal, 8.0)
                            .displayLoadingView(if: !loadingInformation(for: .description))
                            Text("Evolution")
                                .font(Style.Font.bold(sized: 16.0))
                                .padding(.top, 18)
                            PokemonEvolutionChainView(pokemonId: $pokemonId)
                                .padding(.vertical, 12)
                                .displayLoadingView(if: !loadingInformation(for: .evolution))
                        }
                    }
                }
                .padding(.top, 50.0)
            }
            .padding(.top, 62)
            .gesture(
                DragGesture(
                    minimumDistance: 0,
                    coordinateSpace: .global
                )
                .onEnded { value in
                    let verticalAmount = value.translation.height as CGFloat
                    if verticalAmount > 0 {
                        showing = false
                    }
                }
            )
            /// Animated images aren't available for Pokemons with
            /// indexes higher than 649. We'll use static ones instead
            if let pokemon = pokemon {
                if pokemon.id > 649 {
                    KFImage(URL(string: pokemon.listImageStringURL))
                        .frame(width: 110, height: 110)
                } else {
                    if let urlImageString = pokemon.viewImageStringURL {
                        KFAnimatedImage(URL(string: urlImageString))
                            .frame(width: 100, height: 100)
                    } else {                        
                        // Here replace with any placeholder image?
                    }
                }
            }
        }
        .padding(.top, PokemonView.topMargin)
    }
    
    // MARK: View Methods
    /// Gives the loading status for a given kind of fetchable information
    /// - Parameter loadState: The kind of information to load
    /// - Returns: The status for this kind of information
    private func loadingInformation(for loadState: LoadState) -> Bool {
        guard let id = pokemon?.id else {
            return false
        }
        return pokemonCoordinator.pokemonLoadingInformation[id]?[loadState] ?? false
    }
}

#if DEBUG
struct PokemonView_Previews: PreviewProvider {
    private static func view(for id: Int) -> some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            PokemonView(
                pokemonId: .constant(id),
                showing: .constant(true)
            )
            .environmentObject(samplePokemonCoordinator)
        }
    }
    
    static let pokemonsToDisplay = [
//        pokemonSimpleSampleBulbasaur
        pokemonFullSampleEevee
//        pokemonFullSampleCaterpie
    ]
    
    static var previews: some View {
        ForEach(pokemonsToDisplay) {
            view(for: $0.id)
                .environmentObject(samplePokemonCoordinator)
                .previewDevice("iPhone 13 Pro Max")
        }
    }
}
#endif
