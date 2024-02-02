//
//  Badge.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 10/01/2024.
//

import SwiftUI

struct Badge: View {

    @ScaledMetric(relativeTo: .body) private var badgeSize = 24

    let value: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            Text("\(value)")
                .font(.custom("Avenir Next Condensed", size: 18))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, badgeSize/20) // the line height of this font behaves a little weird, adjsuting
        }
        .frame(width: badgeSize, height: badgeSize, alignment: .center)
        .padding(badgeSize/10)
        .background(Color.Colors.badge)
        .clipShape(Circle())
    }
}

#Preview {
    Badge(value: 42)
}
