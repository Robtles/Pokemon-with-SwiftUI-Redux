//
//  Version.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 23/05/2022.
//

import Foundation

// MARK: - Versions
/// Lists all the Pokemon games versions
enum Version: String {
    // MARK: Computed Properties
    static let all: [Version] = [
        .blue,
        .gold,
        .ruby,
        .diamond,
        .black,
        .black2,
        .versionX,
        .sun,
        .ultraSun,
        .sword
    ]
    
    // MARK: Cases
    case blue = "blue"
    case gold = "gold"
    case ruby = "ruby"
    case diamond = "diamond"
    case black = "black"
    case black2 = "black-2"
    case versionX = "x"
    case sun = "sun"
    case ultraSun = "ultra-sun"
    case sword = "sword"
}
