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

extension FactRepositoryImplementation: GetFactRepository {

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
}

extension FactRepositoryImplementation: SaveFactRepository {

    func saveToFavourites(fact: Fact) throws {
        try localStore.addFactToFavourites(fact: fact)
    }
}

extension FactRepositoryImplementation: DeleteFactRepository {

    func deleteFavourite(fact: Fact) throws {
        try localStore.removeFactFromFavourites(fact: fact)
    }
}
