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
}
