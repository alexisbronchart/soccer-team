//
//  PlayerListView.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import SwiftUI
import SwiftData
import OrderedCollections

struct PlayerListView: View {

    @Environment(\.playerEnvironment) private var playerEnvironment
    @Query(
        filter: #Predicate<Player> { $0.category != "STAFF" },
        sort: \Player.shirtNumber
    )
    var players: [Player]
    var groupedPlayers: OrderedDictionary<String, [Player]> {
        OrderedDictionary(grouping: players, by: { $0.category })
    }

    @State private var error: Error?
    @State private var listMode: ListMode = .grouped
    @State private var presentedPlayer: Player?

    var body: some View {
        content
            .background(Color.Colors.background)
            .navigationTitle("TEAM")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbarBackground(Color.clear)
            .toolbarBackground(.visible)
            .toolbarColorScheme(.dark)
            .task {
                do {
                    try await playerEnvironment.syncPlayers()
                } catch {
                    self.error = error
                }
            }
    }

    var content: some View {
        List {
            switch listMode {
            case .flat:
                ForEach(players) { player in
                    PlayerCell(player: player) { player in
                        self.presentedPlayer = player
                    }
                }
            case .grouped:
                ForEach(Array(groupedPlayers.keys), id: \.self) { title in
                    if let players = groupedPlayers[title] {
                        Section {
                            ForEach(players) { player in
                                PlayerCell(player: player) { player in
                                    self.presentedPlayer = player
                                }
                            }
                        } header: {
                            HStack(spacing: 16) {
                                Rectangle()
                                    .frame(width: 4, height: 36)
                                    .foregroundStyle(Color.Colors.divider)
                                Text(title.uppercased())
                                    .foregroundStyle(Color.Colors.divider)
                            }
                            .padding(.leading, -20)
                        }
                        .preferredColorScheme(.dark)
                        .listSectionSeparator(.hidden)
                    }
                }
            }
        }
        .listRowSeparatorTint(Color.Colors.divider)
        .listStyle(.plain)
        .toolbar {
            toolbarItems
        }
#if os(iOS)
        .fullScreenCover(item: $presentedPlayer) { player in
            PlayerDetailsView(player: player)
        }
#else
        .sheet(item: $presentedPlayer) { player in
            PlayerDetailsView(player: player)
                .frame(minHeight: 800)
        }
#endif
    }

    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Menu {
                Button {
                    listMode = .flat
                } label: {
                    Label("Flat list", systemImage: "list.bullet")
                }

                Button {
                    listMode = .grouped
                } label: {
                    Label("Grouped", systemImage: "list.bullet.below.rectangle")
                }
            } label: {
                Image(systemName: listMode == .flat ? "list.bullet" : "list.bullet.below.rectangle")
                    .font(.system(size: 12))
            }
        }
    }

    private enum ListMode {
        case flat, grouped
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Player.self)
}
