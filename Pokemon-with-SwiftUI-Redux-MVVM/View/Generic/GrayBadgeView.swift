//
//  GrayBadgeView.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 20/05/2022.
//

import SwiftUI

// MARK: - Gray Badge View
struct GrayBadgeView: View {
    // MARK: Instance Properties
    let text: String
    
    // MARK: View Properties
    var body: some View {
        ZStack {
            Style.Color.listBackground
                .cornerRadius(30.0)
            Text(text)
                .foregroundColor(Style.Color.blackText)
                .font(Style.Font.regular(sized: 16.0))
        }
        .frame(height: 36.0)
    }
}

struct GrayBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            GrayBadgeView(text: "Solar Power")
                .padding()
        }
        .ignoresSafeArea()
    }
}
