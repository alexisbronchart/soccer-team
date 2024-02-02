//
//  PlayerService.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import Foundation
import Moya

protocol PlayerServiceProtocol {
    func getPlayers() async throws -> [PlayerData]
}

class PlayerService: PlayerServiceProtocol {

    var provider: MoyaProvider<PlayerServiceDefinition>

    init(provider:MoyaProvider<PlayerServiceDefinition> = .init(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }

    func getPlayers() async throws -> [PlayerData] {
        let result: PlayerDataResult = try await provider.async.request(.employees)
        return result.data
    }
}
