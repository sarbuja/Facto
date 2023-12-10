import Foundation

struct Fact: Identifiable, Codable, Hashable {
    private(set) var id = UUID()
    let text: String
}
