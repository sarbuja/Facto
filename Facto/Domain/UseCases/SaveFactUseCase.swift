import Foundation

protocol SaveFactUseCase {
    func saveFactToFavourites(fact: Fact) throws
}

struct SaveToFavouritesUseCaseImplementation: SaveFactUseCase {

    let saveFactRepository: SaveFactRepository

    init(repository: SaveFactRepository) {
        saveFactRepository = repository
    }

    func saveFactToFavourites(fact: Fact) throws {
        try saveFactRepository.saveToFavourites(fact: fact)
    }
}

// MARK: - Previews

struct PreviewSaveFactUseCase: SaveFactUseCase {

    func saveFactToFavourites(fact: Fact) throws {
        // NOT NEEDED FOR PREVIEW
    }
}
