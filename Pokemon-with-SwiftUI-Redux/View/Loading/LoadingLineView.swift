//
//  LoadingLineView.swift
//  LoadingViewTest
//
//  Created by Rob on 26/05/2022.
//

import SwiftUI

// MARK: - Loading Line View
struct LoadingLineView: View {
    // MARK: Instance Properties
    @State private var animatingGradient: CGFloat = 0.1
    
    // MARK: View Properties
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.clear)
            .modifier(LoadingLineViewEffect(position: animatingGradient))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .animation(.linear(duration: 1.0)
                .repeatForever(autoreverses: true), value: animatingGradient)
            .frame(height: 8.0)
            .padding(.horizontal, 16.0)
            .onAppear {
                animatingGradient = 0.9
            }
    }
}

// MARK: - Loading Line View Effect
private struct LoadingLineViewEffect: AnimatableModifier {
    // MARK: Instance Properties
    var position: CGFloat = 0
    
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
    
    // MARK: View Properties
    func body(content: Content) -> some View {
        content.background(
            LinearGradient(
                stops: [
                    .init(color: .gray.opacity(0.05), location: 0.0),
                    .init(color: .gray.opacity(0.3), location: position - 0.05),
                    .init(color: .gray.opacity(0.3), location: position + 0.05),
                    .init(color: .gray.opacity(0.05), location: 1.0)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            .padding(.horizontal, -40)
            .clipped()
        )
    }
}

#if DEBUG
struct LoadingLineView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingLineView()
    }
}
#endif
