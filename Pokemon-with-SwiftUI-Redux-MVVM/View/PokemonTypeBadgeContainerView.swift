//
//  PokemonTypeBadgeView.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 15/05/2022.
//

import SwiftUI

// MARK: - Pokemon Type Badge Container View
struct PokemonTypeBadgeContainerView: View {
    // MARK: Instance Properties
    var pokemonTypes: [PokemonType]
    
    // MARK: View Properties
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ForEach(pokemonTypes, id: \.rawValue) {
                Text($0.name)
                    .font(Style.Font.semibold(sized: 14.0))
                    .foregroundColor($0.foregroundColor)
                    .padding(.vertical, 4.0)
                    .padding(.horizontal, 8.0)
                    .background($0.backgroundColor)
                    .cornerRadius(6.0)
            }
        }
    }
}

#if DEBUG
struct PokemonTypeBadgeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .center) {
            Color.white
            VStack(spacing: 12) {
                PokemonTypeBadgeContainerView(pokemonTypes: pokemonSampleBulbasaur.sortedTypes)
                PokemonTypeBadgeContainerView(pokemonTypes: pokemonSamplePikachu.sortedTypes)
            }
        }
    }
}
#endif
