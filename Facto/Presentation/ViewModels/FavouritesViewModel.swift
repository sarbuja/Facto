import Foundation

@MainActor
final class FavouritesViewModel: ObservableObject {

    let deleteFactUseCase: DeleteFactUseCase
    private let localStore: LocalStore
    @Published var facts: [Fact]?
    @Published private(set) var errorMessage: String = ""

    init(localStore: LocalStore, deleteFactUseCase: DeleteFactUseCase) {
        self.localStore = localStore
        self.deleteFactUseCase = deleteFactUseCase
    }

    func getFacts() {
        facts = localStore.storedFacts
    }

    func removeFact(fact: Fact) {
        do {
            try deleteFactUseCase.deleteFavourite(fact: fact)
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
