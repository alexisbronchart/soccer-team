//
//  PlayerDetailsView.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 11/01/2024.
//

import SwiftUI
import SwiftData
import NukeUI

struct PlayerDetailsView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var width: CGFloat = 0
    @AppStorage("favoritePlayerId") private var favoritePlayerId: Int?

    let player: Player

    var body: some View {
        ZStack(alignment: .top) {
            Color.clear

            gradient
                .zIndex(2)

            ribbon
                .zIndex(3)

            playerImage
                .zIndex(1)

            ZStack(alignment: .bottom) {
                Color.clear
                infoOverlay
            }
            .ignoresSafeArea()
            .zIndex(2)
        }
        .readGeometry(\.size.width, into: $width)
    }

    private var gradient: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .black,
                    .black.opacity(0.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private var ribbon: some View {
        if let number = player.shirtNumber {
            HStack(alignment: .top) {
                Ribbon(value: number)
                    .padding(.leading, 20)
                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                        .padding(20)
                        .foregroundStyle(.white)
                }
            }

        }
    }
    
    @MainActor
    private var playerImage: some View {
        VStack(spacing: 0) {
            LazyImage(url: player.image) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: width)
                        .background(.white)
                } else if state.error != nil {
                    Image(systemName: "xmark.icloud")
                        .imageScale(.large)
                        .foregroundStyle(.red)
                        .background(.white)
                } else {
                    ProgressView()
                }
            }
        }
    }

    private var infoOverlay: some View {
        VStack(alignment: .leading, spacing: 16) {

            // player name
            HStack {
                Text("\(player.firstName.uppercased()) \(player.lastName.uppercased())")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .kerning(1.2)

                if let nationality = player.nationality {
                    Text(Flag.flag(from: nationality))
                        .font(.largeTitle)
                }

                Spacer()

                Star(enabled: favoritePlayerId == player.id) { isEnabled in
                    if isEnabled {
                        favoritePlayerId = nil
                    } else {
                        favoritePlayerId = player.id
                    }
                }
                .tint(Color.Colors.gold)
            }
            .padding(.top, 60)

            // divider
            Rectangle()
                .frame(width: 60, height: 4)
                .foregroundStyle(Color.white.opacity(0.8))

            // player info rows
            if let birthday = player.birthDate {
                infoRow(title: "Birthday", value: birthday.formatted(date: .long, time: .omitted))
            }
            if let country = player.country {
                infoRow(title: "Country of origin", value: country)
            }
            let heightLabel = if let height = player.height {
                "\(height)cm"
            } else {
                "N/A"
            }
            infoRow(title: "Height", value: heightLabel)
        }
        .padding(16)
        .safeAreaPadding(.bottom)
        .background {
            LinearGradient(
                colors: [
                    .black.opacity(0.0),
                    .Colors.background,
                    .Colors.background,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func infoRow(title: LocalizedStringKey, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.white.opacity(0.8))
                .fontWeight(.bold)

            Spacer()

            Text(value)
                .foregroundStyle(Color.white.opacity(0.5))
        }
    }
}


// This preview relies on actual data already being added in SwiftData. If it crashes, try to run the preview of PlayerListView again to ensure the data gets loaded first and make sure the id exists
#Preview {
    _Preview()
        .modelContainer(for: Player.self)
}

private struct _Preview: View {
    static let id = 239
    @Query(filter: #Predicate<Player> { $0.id == id }) var player: [Player]

    var body: some View {
        PlayerDetailsView(player: player.first!)
    }
}
