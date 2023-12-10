import Foundation

@MainActor
final class FactViewModel: ObservableObject {

    let getFactUseCase: GetFactUseCase
    let saveFactUseCase: SaveFactUseCase
    @Published private(set) var fact: Fact?
    @Published var errorMessage: String = ""
    @Published private(set) var showLoading: Bool = false
    @Published var showFavouriting: Bool = false

    init(getFactUseCase: GetFactUseCase, saveFactUseCase: SaveFactUseCase) {
        self.getFactUseCase = getFactUseCase
        self.saveFactUseCase = saveFactUseCase
    }

    func getFact() async {
        do {
            showLoading = true
            fact = try await getFactUseCase.getFact()
            showLoading = false
        } catch {
            showLoading = false
            errorMessage = error.localizedDescription
        }
    }

    func saveFactToFavourites(fact: Fact) throws {
        do {
            try saveFactUseCase.saveFactToFavourites(fact: fact)
            showFavouriting = true
        } catch {
            errorMessage = error.localizedDescription
            throw LocalStoreError.factAlreadyFavourited
        }
    }
}
