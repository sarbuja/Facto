import XCTest
@testable import Facto

final class SaveFactUseCaseTest: XCTestCase {

    var saveFactRepoSpy: SaveFactRepositorySpy!

    override func setUp() {
        saveFactRepoSpy = SaveFactRepositorySpy()
    }

    func test_saveFact_is_called() {
        XCTAssertFalse(saveFactRepoSpy.saveFactIsCalled)

        let sut = SaveToFavouritesUseCaseImplementation(repository: saveFactRepoSpy)
        try! sut.saveFactToFavourites(fact: Fact(text: "A Mock Fact"))
        XCTAssertTrue(saveFactRepoSpy.saveFactIsCalled)
    }
}

final class SaveFactRepositorySpy: SaveFactRepository {

    var saveFactIsCalled = false

    func saveToFavourites(fact: Fact) throws {
        saveFactIsCalled = true
    }
}
