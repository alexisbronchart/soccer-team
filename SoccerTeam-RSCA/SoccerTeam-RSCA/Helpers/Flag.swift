import Foundation

/// Taken from https://stackoverflow.com/questions/30402435/swift-turn-a-country-code-into-a-emoji-flag-via-unicode
enum Flag {
    static func flag(from country: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
