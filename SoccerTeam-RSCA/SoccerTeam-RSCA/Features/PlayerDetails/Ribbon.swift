//
//  Ribbon.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 11/01/2024.
//

import SwiftUI

struct Ribbon: View {

    @ScaledMetric(relativeTo: .body) private var size = 40

    let value: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear

            Text("\(value)")
                .font(.custom("Avenir Next Condensed", size: 36))
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .frame(width: size, height: size*2)
        .padding(size/10)
        .background(Color.Colors.gold)
    }
}

#Preview {
    Ribbon(value: 42)
}
