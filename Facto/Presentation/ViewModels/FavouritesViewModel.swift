import Foundation

@MainActor
final class FavouritesViewModel: ObservableObject {

    private let localStore: LocalStore
    @Published var facts: [Fact]?
    @Published private(set) var errorMessage: String = ""

    init(localStore: LocalStore) {
        self.localStore = localStore
    }

    func getFacts() {
        facts = localStore.storedFacts
    }

    func removeFact(fact: Fact) {
        do {
            try localStore.removeFactFromFavourites(fact: fact)
            facts = localStore.storedFacts
        } catch {
            print(error.localizedDescription)
        }
    }

    func filterFacts(text: String) {
        if text.isEmpty {
            facts = localStore.storedFacts
        } else {
            facts = facts?.filter { $0.text.localizedCaseInsensitiveContains(text) }
        }
    }
}
