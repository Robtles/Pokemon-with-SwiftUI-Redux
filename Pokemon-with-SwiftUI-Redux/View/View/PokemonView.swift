//
//  PokemonView.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 17/05/2022.
//

import Kingfisher
import SwiftUI
import SwiftUIFlux

// MARK: - Pokemon View
/// Describes a view containing all the information of a given `Pokemon`
struct PokemonView: ConnectedView {
    // MARK: Flux
    struct Props {
        let loadState: [LoadState: Bool]
        let pokemon: Pokemon?
    }
    
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        return Props(
            loadState: state.pokemonState.loadingState[pokemonId ?? -1] ?? [:],
            pokemon: state.pokemonState.pokemons.first(where: { $0.id == pokemonId })
        )
    }

    // MARK: Static Properties
    private static let buttonMargin: CGFloat = 16.0
    private static let topMargin: CGFloat = 50.0

    // MARK: Instance Properties
    /// The selected Pokemon id
    @Binding var pokemonId: Int?
    /// The variable that handles the view visibility
    @Binding var showing: Bool

    // MARK: View Properties
    func body(props: Props) -> some View {
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
                            headerInformation(props: props)
                            PokemonTypeBadgeContainerView(pokemonTypes: props.pokemon?.sortedTypes ?? [])
                                .padding(.top, 8)
                            descriptiveInformation(props: props)
                            abilitiesInformation(props: props)
                        }
                        VStack(spacing: 0) {
                            statsInformation(props: props)
                            evolutionInformation(props: props)
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
            topImage(props: props)
        }
        .padding(.top, PokemonView.topMargin)
    }
    
    // MARK: Internal Views
    private func abilitiesInformation(props: Props) -> some View {
        VStack(spacing: 0) {
            Text("Abilities")
                .font(Style.Font.bold(sized: 16.0))
                .padding(.top, 18)
            HStack {
                ForEach(props.pokemon?.abilities ?? [], id: \.self) {
                    GrayBadgeView(text: $0)
                }
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 8.0)
            .displayLoadingView(if: !loadingInformation(from: props, for: .description))
        }
    }
    
    private func descriptiveInformation(props: Props) -> some View {
        VStack(spacing: 0) {
            Text("Pokedex entry")
                .font(Style.Font.bold(sized: 16.0))
                .padding(.top, 18)
            Text(props.pokemon?.description ?? "")
                .multilineTextAlignment(.center)
                .font(Style.Font.regular(sized: 16.0))
                .foregroundColor(Style.Color.grayText)
                .padding(.top, 6)
                .padding(.horizontal, 8)
                .displayLoadingView(if: !loadingInformation(from: props, for: .species))
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
                GrayBadgeView(text: "\(props.pokemon?.height ?? 0)m")
                    .displayLoadingView(if: !loadingInformation(from: props, for: .description))
                GrayBadgeView(text: "\(props.pokemon?.weight ?? 0)kg")
                    .displayLoadingView(if: !loadingInformation(from: props, for: .description))
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 8.0)
        }
    }
    
    private func evolutionInformation(props: Props) -> some View {
        VStack(spacing: 0) {
            Text("Evolution")
                .font(Style.Font.bold(sized: 16.0))
                .padding(.top, 18)
            PokemonEvolutionChainView(pokemonId: $pokemonId)
                .padding(.vertical, 12)
                .displayLoadingView(if: !loadingInformation(from: props, for: .evolution))
        }
    }
    
    private func headerInformation(props: Props) -> some View {
        VStack(spacing: 0) {
            Text("N° \(props.pokemon?.id ?? 0)")
                .font(Style.Font.bold(sized: 12.0))
                .foregroundColor(Style.Color.grayText)
            Text(props.pokemon?.name ?? "")
                .padding(.top, 6)
                .font(Style.Font.bold(sized: 24.0))
                .foregroundColor(Style.Color.blackText)
        }
    }
    
    private func statsInformation(props: Props) -> some View {
        VStack(spacing: 0) {
            Text("Stats")
                .font(Style.Font.bold(sized: 16.0))
                .padding(.top, 18)
                .padding(.bottom, 12)
            HStack {
                ForEach(PokemonStat.sorted, id: \.rawValue) { stat in
                    if let value = props.pokemon?.stats?[stat] {
                        PokemonStatView(viewType: .stat(stat, value))
                    }
                }
                PokemonStatView(viewType:
                        .total((props.pokemon?.stats ?? [:])
                            .mapValues { $0 }
                            .reduce(0, { $0 + $1.value }))
                )
            }
            .padding(.horizontal, 8.0)
            .displayLoadingView(if: !loadingInformation(from: props, for: .description))
        }
    }
    
    private func topImage(props: Props) -> some View {
        VStack(spacing: 0) {
            /// Animated images aren't available for Pokemons with
            /// indexes higher than 649. We'll use static ones instead
            if let pokemon = props.pokemon {
                if pokemon.id > 649 {
                    KFImage(URL(string: pokemon.listImageStringURL))
                        .placeholder {
                            Style.image(.unknownPlaceholder)
                                .frame(width: 80, height: 80)
                        }
                        .frame(width: 110, height: 110)
                } else {
                    if let urlImageString = pokemon.viewImageStringURL {
                        KFAnimatedImage(URL(string: urlImageString))
                            .placeholder {
                                Style.image(.unknownPlaceholder)
                                    .frame(width: 80, height: 80)
                            }
                            .frame(width: 100, height: 100)
                    } else {
                        Style.image(.unknownPlaceholder)
                            .frame(width: 80, height: 80)
                    }
                }
            }
        }
    }
    
    // MARK: View Methods
    /// Gives the loading status for a given kind of fetchable information
    /// - Parameters:
    ///   - props: The view props
    ///   - loadState: The kind of information to load
    /// - Returns: The status for this kind of information
    private func loadingInformation(from props: Props, for loadState: LoadState) -> Bool {
        return props.loadState[loadState] ?? false
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
            .environmentObject(sampleStore(with: pokemonsToDisplay))
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
                .environmentObject(sampleStore(with: pokemonsToDisplay))
                .previewDevice("iPhone 13 Pro Max")
        }
    }
}
#endif
