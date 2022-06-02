//
//  PokemonStatView.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 20/05/2022.
//

import SwiftUI

// MARK: - Pokemon Stat View
struct PokemonStatView: View {
    // MARK: Type Properties
    /// The visual type of `PokemonStat`
    enum ViewType {
        // MARK: Cases
        /// Represents one of the Pokemon stats
        case stat(PokemonStat, Int)
        /// Represents the total of all stats
        case total(Int)
        
        // MARK: Computed Properties
        var backgroundColor: Color {
            switch self {
            case .stat:
                return Style.Color.listBackground
            case .total:
                return Style.Color.blueStatBackgroundColor
            }
        }
        
        var value: Int {
            switch self {
            case .stat(_, let value):
                return value
            case .total(let value):
                return value
            }
        }
    }
    
    // MARK: Instance Properties
    let viewType: ViewType
    
    // MARK: View Properties
    var body: some View {
        ZStack(alignment: .top) {
            viewType.backgroundColor
                .cornerRadius(30.0)
            VStack(spacing: 6) {
                ZStack {
                    switch viewType {
                    case .stat(let pokemonStat, _):
                        pokemonStat.backgroundColor
                            .frame(width: 26.0, height: 26.0)
                            .cornerRadius(13.0)
                            .padding(.top, 2)
                        Text(pokemonStat.name)
                            .font(Style.Font.bold(sized: 10.0))
                            .foregroundColor(.white)
                    case .total:
                        Style.Color.blueStatForegroundColor
                            .frame(width: 26.0, height: 26.0)
                            .cornerRadius(13.0)
                            .padding(.top, 2)
                        Text("TOT")
                            .font(Style.Font.bold(sized: 10.0))
                            .foregroundColor(.white)
                    }
                }
                Text("\(viewType.value)")
                    .font(Style.Font.bold(sized: 13.0))
                    .foregroundColor(.black)
            }
            .padding(.top, 4)
        }
        .frame(width: 35.0, height: 64.0)
    }
}

#if DEBUG
struct PokemonStatView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            HStack {
                PokemonStatView(viewType: .stat(.specialDefense, 120))
                PokemonStatView(viewType: .stat(.attack, 40))
                PokemonStatView(viewType: .total(160))
            }
        }
        .ignoresSafeArea()
    }
}
#endif
