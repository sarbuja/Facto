import Foundation

final class FavouritesLocalStore {

    var storedFacts: [Fact]? {
        get {
            print("file url: \(try! fileURL.absoluteString)")
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            return try? JSONDecoder().decode([Fact].self, from: data)
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            try? data?.write(to: fileURL)
        }
    }

    private let fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager

        if storedFacts == nil {
            storedFacts = []
        }
    }

    var fileURL: URL {
        get throws {
            try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appending(path: "facts")
        }
    }
}

extension FavouritesLocalStore: LocalStore {

    func addFactToFavourites(fact: Fact) throws {
        guard let facts = storedFacts,
              !facts.contains(fact) else {
            throw LocalStoreError.factAlreadyFavourited
        }
        storedFacts?.append(fact)
    }

    func removeFactFromFavourites(fact: Fact) throws {
        guard let index = storedFacts?.firstIndex(of: fact) else {
            throw LocalStoreError.factNotFound
        }
        storedFacts?.remove(at: index)
    }
}

// MARK: - Test Data for Previews

class PreviewsFavouriteStore: LocalStore {

    var storedFacts: [Fact]? = [Fact(text: "Hello world, this is a preview fact."),
                                Fact(text: "The wheels on the bus go round and round.")]

    func addFactToFavourites(fact: Fact) throws {

    }

    func removeFactFromFavourites(fact: Fact) throws {

    }
}
