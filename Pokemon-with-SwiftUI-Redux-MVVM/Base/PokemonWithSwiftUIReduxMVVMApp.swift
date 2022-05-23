//
//  PokemonWithSwiftUIReduxMVVMApp.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 07/05/2022.
//

import SwiftUI

@main
struct PokemonWithSwiftUIReduxMVVMApp: App {
    // MARK: Properties
    /// Contains all the `Pokemon` and will broadcast any info update
    @EnvironmentObject var pokemonCoordinator: PokemonCoordinator
    
    // MARK: - View
    var body: some Scene {
        WindowGroup {
            PokemonList()
                .environmentObject(PokemonCoordinator())
        }
    }
}
