//
//  PlayerEnvironment.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import Foundation
import SwiftUI

@MainActor 
struct PlayerEnvironment {
    var syncPlayers: () async throws -> Void

    init(
        syncPlayers: @escaping () async throws -> Void
    ) {
        self.syncPlayers = syncPlayers
    }
}

private extension PlayerEnvironment {
    enum Key: EnvironmentKey {
        static var defaultValue = PlayerEnvironment.preview
    }
}

extension EnvironmentValues {
    var playerEnvironment: PlayerEnvironment {
        get { self[PlayerEnvironment.Key.self] }
        set { self[PlayerEnvironment.Key.self] = newValue }
    }
}

extension PlayerEnvironment {
    static let preview = PlayerEnvironment(
        syncPlayers: {}
    )
}
