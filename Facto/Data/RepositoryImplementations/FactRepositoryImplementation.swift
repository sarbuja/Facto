import Foundation

enum DataSourceError: Error, Equatable {
    case noDataInFavourites
}

class FactRepositoryImplementation {

    let factService: FactService
    let localStore: LocalStore

    init(factService: FactService, localStore: LocalStore) {
        self.factService = factService
        self.localStore = localStore
    }
}

extension FactRepositoryImplementation: FactRepository {

    func getFact() async throws -> Fact {
        do {
            return try await factService.getFact()
        } catch URLError.notConnectedToInternet {
            guard let fact = localStore.storedFacts?.randomElement() else {
                throw DataSourceError.noDataInFavourites
            }
            return fact
        }
    }

    func saveToFavourites(fact: Fact) throws {
        try localStore.addFactToFavourites(fact: fact)
    }

    func deleteFavourite(fact: Fact) throws {
        try localStore.removeFactFromFavourites(fact: fact)
    }
}
