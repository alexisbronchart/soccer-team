//
//  SoccerTeam_RSCAApp.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import SwiftUI
import SwiftData

@main
struct SoccerTeam_RSCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Player.self)
    }
}
