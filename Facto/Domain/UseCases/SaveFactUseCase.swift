import Foundation

protocol SaveFactUseCase {
    func saveFactToFavourites(fact: Fact) throws
}

struct SaveToFavouritesUseCaseImplementation: SaveFactUseCase {

    let factRepository: FactRepository

    func saveFactToFavourites(fact: Fact) throws {
        try factRepository.saveToFavourites(fact: fact)
    }
}

// MARK: - Previews

struct PreviewSaveFactUseCase: SaveFactUseCase {

    func saveFactToFavourites(fact: Fact) throws {
        // NOT NEEDED FOR PREVIEW
    }
}
