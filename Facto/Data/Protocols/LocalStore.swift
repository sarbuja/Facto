import Foundation

protocol LocalStore {
    var storedFacts: [Fact]? { get set }
    func addFactToFavourites(fact: Fact) throws
    func removeFactFromFavourites(fact: Fact) throws
}

enum LocalStoreError: String, LocalizedError {
    case factAlreadyFavourited = "Fact is already favourited"
    case factNotFound = "Fact not found"

    var errorDescription: String? {
        return self.rawValue
    }
}
