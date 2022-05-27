//
//  LoadingView.swift
//  LoadingViewTest
//
//  Created by Rob on 26/05/2022.
//

import SwiftUI

// MARK: - Loading View
struct LoadingView: View {
    // MARK: Instance Properties
    @State private var loading: Bool = false
    
    // MARK: View Properties
    var body: some View {
        VStack(spacing: 8) {
            LoadingLineView()
            LoadingLineView()
        }
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
#endif
