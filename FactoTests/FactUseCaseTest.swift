import XCTest
@testable import Facto

final class FactUseCaseTest: XCTestCase {

    var repoSpy: FactRepositorySpy!
    var repoStub: FactRepositoryThrowingStub!

    override func setUp() {
        super.setUp()
        repoSpy = FactRepositorySpy()
        repoStub = FactRepositoryThrowingStub()
    }

    override func tearDown() {
        repoSpy = nil
        repoStub = nil
        super.tearDown()
    }

    func test_getFact_is_called() async {
        XCTAssertFalse(repoSpy.getFactCalled)

        let sut = GetFactUseCaseImplementation(factRepository: repoSpy)
        _ = try! await sut.getFact()
        XCTAssertTrue(repoSpy.getFactCalled)
    }

    func test_saveFact_is_called() {
        XCTAssertFalse(repoSpy.saveFactIsCalled)

        let sut = SaveToFavouritesUseCaseImplementation(factRepository: repoSpy)
        try! sut.saveFactToFavourites(fact: Fact(text: "A Mock Fact"))
        XCTAssertTrue(repoSpy.saveFactIsCalled)
    }

    func test_deleteFact_is_called() {
        XCTAssertFalse(repoSpy.deleteFavCalled)

        let sut = DeleteFavouriteUseCaseImplementation(factRepository: repoSpy)
        try! sut.deleteFavourite(fact: Fact(text: "A Mock Fact"))
        XCTAssertTrue(repoSpy.deleteFavCalled)
    }

    func test_getFact_throws_error_when_fetching_fails() async {
        let sut = GetFactUseCaseImplementation(factRepository: repoStub)

        await XCTAssertThrowsErrorAsync(try await sut.getFact())
    }

    func test_deleteFact_throws_error_when_deleting_fails() {
        let sut = DeleteFavouriteUseCaseImplementation(factRepository: repoStub)
        XCTAssertThrowsError(try sut.deleteFavourite(fact: Fact(text: "A Mock Fact")))
    }
}

final class FactRepositorySpy: FactRepository {

    var saveFactIsCalled = false
    var getFactCalled = false
    var deleteFavCalled = false

    func getFact() async throws -> Fact {
        getFactCalled = true
        return Fact(text: "test fact")
    }

    func saveToFavourites(fact: Fact) throws {
        saveFactIsCalled = true
    }

    func deleteFavourite(fact: Facto.Fact) throws {
        deleteFavCalled = true
    }
}

final class FactRepositoryThrowingStub: FactRepository {

    func getFact() async throws -> Fact {
        throw NetworkError.statusError
    }

    func deleteFavourite(fact: Facto.Fact) throws {
        throw LocalStoreError.factNotFound
    }

    func saveToFavourites(fact: Facto.Fact) throws {
        throw NetworkError.statusError
    }
}
