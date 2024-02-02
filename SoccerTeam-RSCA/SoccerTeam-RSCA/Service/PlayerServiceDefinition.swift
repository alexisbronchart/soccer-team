//
//  PlayerServiceDefinition.swift
//  SoccerTeam-RSCA
//
//  Created by Alexis Bronchart on 09/01/2024.
//

import Foundation
import Moya

// MARK: Constants

let apiURL = URL(string: "https://rsca-0002-prod.novemberfive.co/api/")!

// MARK: - Service Definition

enum PlayerServiceDefinition {
    case employees
}

// MARK: - TargetType Protocol Implementation

extension PlayerServiceDefinition: TargetType {
    var baseURL: URL {
        return apiURL
    }
    var path: String {
        switch self {
        case .employees:
            return "employees"
        }
    }
    var method: Moya.Method {
        switch self {
        case .employees:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    var task: Task {
        switch self {
        case .employees:
            return .requestPlain
        }
    }
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
