//
//  PokemonListRow.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 13/05/2022.
//

import Kingfisher
import SwiftUI

// MARK: - Pokemon List Row View
struct PokemonListRow: View {
    // MARK: Instance Properties
    var pokemon: Pokemon
    
    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .cornerRadius(20.0)
                .shadow(
                    color: Style.Color.listBoxShadow,
                    radius: 6.0,
                    x: 0.0,
                    y: 10.0)
                .padding(.top, 60)
            KFImage(URL(string: pokemon.listImageStringURL))
                .frame(width: 110, height: 110)
            VStack(alignment: .center, spacing: 0) {
                Text("N°\(pokemon.id)")
                    .font(Style.Font.bold(sized: 12.0))
                    .foregroundColor(Color.gray)
                Color.white
                    .frame(height: 6)
                Text(pokemon.name ?? "-")
                    .font(Style.Font.bold(sized: 18.0))
                    .foregroundColor(Color.black)
                Color.white
                    .frame(height: 10)
                PokemonTypeBadgeContainerView(pokemonTypes: pokemon.sortedTypes)
                    .frame(height: 40)
            }
            .padding(.top, 100)
        }
        .frame(height: 210)
        .padding(.horizontal, 2)
    }
}

#if DEBUG
struct PokemonListRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .center) {
            Style.Color.listBackground
                .ignoresSafeArea()
            HStack(spacing: 0) {
                ForEach([
                    pokemonSampleBulbasaur,
                    pokemonSampleIvysaur
                ]) {
                    PokemonListRow(pokemon: $0)
                }
            }
        }
    }
}
#endif
