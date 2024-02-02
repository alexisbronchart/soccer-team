//
//  Player.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import Foundation
import SwiftData

@Model
class Player {
    @Attribute(.unique) var id: Int
    var firstName: String
    var lastName: String
    var avatar: URL
    var image: URL?
    var category: String
    var height: Int?
    var shirtNumber: Int?
    var birthDate: Date?
    var country: String?
    var role: String?
    var nationality: String?

    init(
        id: Int,
        firstName: String,
        lastName: String,
        avatar: URL,
        image: URL? = nil,
        category: String,
        height: Int? = nil,
        shirtNumber: Int? = nil,
        birthDate: Date? = nil,
        country: String? = nil,
        role: String? = nil,
        nationality: String?
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.image = image
        self.category = category
        self.height = height
        self.shirtNumber = shirtNumber
        self.birthDate = birthDate
        self.country = country
        self.role = role
        self.nationality = nationality
    }
}
