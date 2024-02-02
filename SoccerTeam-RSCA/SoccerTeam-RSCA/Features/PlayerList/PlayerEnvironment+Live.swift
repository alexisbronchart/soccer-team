//
//  PlayerEnvironment.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import Foundation
import SwiftUI
import SwiftData

extension PlayerEnvironment {
    static func live(using service: PlayerServiceProtocol, and modelContext: ModelContext) -> Self {
        .init(
            syncPlayers: {
                // fetch player data
                let playerData = try await service.getPlayers()
                
                // update DB
                let players: [Player] = playerData.map({ .init(data: $0) })
                try players.forEach { player in
                    
                    let existingId = player.id
                    
                    let descriptor = FetchDescriptor(
                        predicate: #Predicate<Player> {
                            $0.id == existingId
                        }
                    )
                    
                    if let existingPlayer = try modelContext.fetch(descriptor).first {
                        existingPlayer.update(with: player)
                    } else {
                        modelContext.insert(player)
                    }
                }
            }
        )
    }
}

private extension Player {
    convenience init(data: PlayerData) {
        self.init(
            id: data.id,
            firstName: data.firstName,
            lastName: data.lastName,
            avatar: data.avatar,
            image: data.image,
            category: data.category,
            height: data.height,
            shirtNumber: data.shirtNumber,
            birthDate: data.birthDate,
            country: data.country,
            role: data.role,
            nationality: data.nationality
        )
    }
    
    func update(with player: Player) {
        self.firstName = player.firstName
        self.lastName = player.lastName
        self.avatar = player.avatar
        self.image = player.image
        self.category = player.category
        self.height = player.height
        self.shirtNumber = player.shirtNumber
        self.birthDate = player.birthDate
        self.country = player.country
        self.role = player.role
        self.nationality = player.nationality
    }
}
