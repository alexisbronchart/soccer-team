//
//  PlayerCell.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 10/01/2024.
//

import SwiftUI
import NukeUI

struct PlayerCell: View {

    @ScaledMetric(relativeTo: .headline) private var avatarSize = 50
    @AppStorage("favoritePlayerId") private var favoritePlayerId: Int?

    let player: Player
    let onTap: ((_ player: Player) -> Void)?


    var body: some View {
        HStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                LazyImage(url: player.avatar) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .frame(width: avatarSize, height: avatarSize)
                            .background(.white)
                            .clipShape(Circle())
                    } else if state.error != nil {
                        Image(systemName: "xmark.icloud")
                            .imageScale(.large)
                            .frame(width: avatarSize, height: avatarSize)
                            .foregroundStyle(.red)
                            .background(.white)
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .frame(width: avatarSize, height: avatarSize)
                    }
                }
                if let number = player.shirtNumber {
                    Badge(value: number)
                        .padding(.trailing, -8)
                        .padding(.bottom, -2)
                }
            }

            VStack(alignment: .leading) {
                HStack {
                    Text("\(player.firstName) \(player.lastName)")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .kerning(1.2)

                    if favoritePlayerId == player.id {
                        Image(systemName: "star.fill")
                            .font(.headline)
                            .foregroundStyle(Color.Colors.gold)
                    }
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(Color.Colors.divider)
        }
        .frame(maxHeight: .infinity)
        .listRowBackground(Color.Colors.background)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?(player)
        }
    }
}
