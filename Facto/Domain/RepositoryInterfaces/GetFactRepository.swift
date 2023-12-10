import Foundation

protocol GetFactRepository {
    func getFact() async throws -> Fact
}
