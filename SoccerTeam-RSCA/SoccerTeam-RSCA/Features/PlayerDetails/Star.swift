//
//  Star.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 11/01/2024.
//

import SwiftUI

struct Star: View {

    let enabled: Bool
    let onTap: (_ isEnabled: Bool) -> Void

    var body: some View {
        Button {
            onTap(enabled)
        } label: {
            Image(systemName: enabled ? "star.fill" : "star")
                .font(.title)
                .contentTransition(.symbolEffect(.replace))
        }
#if os(iOS)
        .addTapHaptic(style: enabled ? .soft : .rigid)
#endif
    }
}

private struct _Preview: View {
    @State var enabled = false

    var body: some View {
        Star(enabled: enabled) { _ in
            enabled.toggle()
        }
        .tint(.green)
    }
}

#Preview {
    _Preview()
}
