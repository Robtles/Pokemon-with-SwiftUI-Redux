//
//  PokemonListLoadingView.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 17/05/2022.
//

import SwiftUI

// MARK: - Loading View
/// The view to display while data is being fetched in PokemonList view
struct PokemonListLoadingView: ViewModifier {
    // MARK: Instance Properties
    @State private var isAnimating = false
    @Binding var loading: Bool
    
    // MARK: Computed Properties
    /// The endless rotating animation
    private var foreverAnimation: Animation {
        return Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    // MARK: View Properties
    func body(content: Content) -> some View {
        content.overlay(
            VStack(spacing: 0) {
                if loading {
                    ZStack(alignment: .center) {
                        Color.white
                        Style.image(.pokeBallIcon)
                            .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0.0))
                            .animation(foreverAnimation, value: isAnimating)
                    }
                    .transition(AnyTransition
                        .move(edge: .top)
                    )
                    .onAppear {
                        isAnimating = true
                    }
                    .onDisappear {
                        isAnimating = false
                    }
                }
            }
            .animation(.easeInOut(duration: 0.6), value: !loading)
        )
    }
}

#if DEBUG
struct PokemonListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .center) {
            Color.white
            Style.image(.pokeBallIcon)
        }
    }
}
#endif
