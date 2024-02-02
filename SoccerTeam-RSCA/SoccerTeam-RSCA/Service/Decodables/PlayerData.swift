//
//  PlayerData.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import Foundation

struct PlayerDataResult: Decodable {
    let data: [PlayerData]
}

struct PlayerData: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: URL
    let image: URL?
    let category: String
    let height: Int?
    let shirtNumber: Int?
    let birthDate: Date?
    let country: String?
    let role: String?
    let nationality: String?
}
