//
//  URL+Extension.swift
//  FinalTestAPI
//
//  Created by Rob on 13/05/2022.
//

import Foundation

extension String {
    /// Tries to extract the id from an URL string (i.e.: `http://theurl.com/info/23/` returns `23`)
    var extractedIdFromUrl: Int? {
        return Int(self
            .components(separatedBy: "/")
            .filter { !$0.isEmpty }
            .last ?? "")
    }
    
    /// Fixes the Nidoran male and female names, and capitalizes every name whatsoever
    var fixedName: String {
        if hasSuffix("-m") {
            return replacingOccurrences(of: "-m", with: "♂").capitalized
        } else if hasSuffix("-f") {
            return replacingOccurrences(of: "-f", with: "♀").capitalized
        } else {
            return capitalized
        }
    }
}
