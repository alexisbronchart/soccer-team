//
//  ContentView.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    let playerService = PlayerService()

    var body: some View {
        NavigationStack {
            PlayerListView()
        }
        .environment(\.playerEnvironment, .live(using: playerService, and: modelContext))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Player.self)
}
