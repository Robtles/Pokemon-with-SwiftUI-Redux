//
//  SlidingModal.swift
//  Pokemon-with-SwiftUI-Redux-MVVM
//
//  Created by Rob on 18/05/2022.
//

import SwiftUI

extension View {
    func showModal(_ modal: Modal, if presented: Binding<Bool>) -> ModifiedContent<Self, SlidingModalViewModifier> {
        return modifier(SlidingModalViewModifier(modal, presented: presented))
    }
}

// MARK: - Sliding Modal View Modifier
/// This component displays content in its superview with a slide from bottom animation
struct SlidingModalViewModifier: ViewModifier {
    // MARK: Instance Properties
    /// The modal to display
    private var modal: Modal
    /// Defines if this view should appear
    @Binding private var presented: Bool
    
    // MARK: View Properties
    func body(content: Content) -> some View {
        content.overlay(
            ZStack {
                VStack {
                    if presented {
                        Color.black.opacity(0.8)
                            .transition(.opacity)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    presented = false
                                }
                            }
                    }
                }
                .animation(
                    .easeInOut(duration: 0.25),
                    value: presented
                )
                VStack {
                    if presented {
                        modal.body(visibilityParameter: $presented)
                            .transition(.move(edge: .bottom))
                    }
                }
                .animation(
                    .default,
                    value: presented
                )
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .ignoresSafeArea()
        )
    }
    
    // MARK: Init Methods
    init(_ modal: Modal, presented: Binding<Bool>) {
        self.modal = modal
        self._presented = presented
    }
}
