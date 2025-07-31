import Foundation

struct Fact: Identifiable, Codable, Hashable {
    var id: Int { text.hashValue }
    let text: String

    enum CodingKeys: String, CodingKey {
        case text = "fact"
    }
}
