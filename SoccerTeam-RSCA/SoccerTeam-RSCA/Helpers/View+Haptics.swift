//
//  View+Haptics.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 11/01/2024.
//

#if os(iOS)
import SwiftUI

private struct AddHapticModifier: ViewModifier {
    var impactGenerator: UIImpactFeedbackGenerator

    init(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        self.impactGenerator = .init(style: style)
    }

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        impactGenerator.impactOccurred()
                    }
            )
    }
}

extension View {
    func addTapHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle) -> some View {
        modifier(
            AddHapticModifier(style: style)
        )
    }
}

#endif
