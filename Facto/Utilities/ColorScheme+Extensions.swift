import SwiftUI

extension ColorScheme: RawRepresentable, Codable {

    public typealias RawValue = String

    public var rawValue: RawValue {
        switch self {
        case .light: return "light"
        case .dark: return "dark"
        @unknown default: return ""
        }
    }

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "light": self = .light
        case "dark": self = .dark
        default: return nil
        }
    }
}
