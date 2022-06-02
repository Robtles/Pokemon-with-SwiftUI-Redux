//
//  LoadingViewModifier.swift
//  LoadingViewTest
//
//  Created by Rob on 26/05/2022.
//

import SwiftUI

// MARK: - View Extension
extension View {
    func displayLoadingView(if isLoading: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(loading: isLoading))
    }
    
    func displayLoadingView(if isLoading: Bool) -> some View {
        let bindingLoading = Binding<Bool>(get: { isLoading }, set: { _ in })
        return modifier(LoadingViewModifier(loading: bindingLoading))
    }
}

// MARK: - Loading View Modifier
struct LoadingViewModifier: ViewModifier {
    // MARK: Instance Properties
    @Binding var loading: Bool
    
    // MARK: View Properties
    func body(content: Content) -> some View {
        ZStack {
            if loading {
                LoadingView()
            } else {
                content
            }
        }
    }
}
