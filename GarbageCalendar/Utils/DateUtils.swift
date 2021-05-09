import Foundation

public struct DateUtils {
    static func day(_ timeInterval: TimeInterval) -> Int { Int(timeInterval / 86400) }
}
