//
//  View+Geometry.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 11/01/2024.
//

import SwiftUI

extension View {
    func readGeometry<Value: Equatable>(
        _ selector: @escaping (GeometryProxy) -> Value,
        into binding: Binding<Value>,
        condition: Bool = true
    ) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        if condition {
                            binding.wrappedValue = selector(proxy)
                        }
                    }
                    .onChange(of: selector(proxy)) { _, newValue in
                        if condition {
                            binding.wrappedValue = newValue
                        }
                    }
            }
        )
    }
}
