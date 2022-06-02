//
//  PokedexApp.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 07/05/2022.
//

import SwiftUI
import SwiftUIFlux

/// Contains the app store
let store = Store<AppState>(
    reducer: appReducer,
    state: AppState()
)

@main
struct PokedexApp: App {
    // MARK: - View
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                PokemonList()
            }
        }
    }
}
