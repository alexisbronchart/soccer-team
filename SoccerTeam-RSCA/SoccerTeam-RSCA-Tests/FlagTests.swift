//
//  FlagTests.swift
//  SoccerTeam-RSCA-Tests
//
//  Created by Alexis Bronchart on 11/01/2024.
//

import Foundation
@testable import SoccerTeam_RSCA
import XCTest

final class FlagTests: XCTestCase {

    func testFlags() {
        _testFlag(for: "BE", expectedEmoji: "🇧🇪")
        _testFlag(for: "FR", expectedEmoji: "🇫🇷")
        _testFlag(for: "NL", expectedEmoji: "🇳🇱")
        _testFlag(for: "DE", expectedEmoji: "🇩🇪")
        _testFlag(for: "DK", expectedEmoji: "🇩🇰")
        _testFlag(for: "SN", expectedEmoji: "🇸🇳")
        _testFlag(for: "SE", expectedEmoji: "🇸🇪")
        _testFlag(for: "GH", expectedEmoji: "🇬🇭")
        _testFlag(for: "GN", expectedEmoji: "🇬🇳")
        _testFlag(for: "NO", expectedEmoji: "🇳🇴")
        _testFlag(for: "AR", expectedEmoji: "🇦🇷")
        _testFlag(for: "EC", expectedEmoji: "🇪🇨")
        _testFlag(for: "GB", expectedEmoji: "🇬🇧")
    }

    private func _testFlag(for code: String, expectedEmoji: String) {
        let value = Flag.flag(from: code)
        XCTAssertEqual(value, expectedEmoji)
    }
}
