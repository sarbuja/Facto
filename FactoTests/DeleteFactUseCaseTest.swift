import XCTest
@testable import Facto

final class DeleteFactUseCaseTest: XCTestCase {

    var deleteFavRepoSpy: DeleteFavouriteRepoSpy!
    var deleteFavRepoStub: DeleteFavouriteThrowingStub!

    override func setUp() {
        deleteFavRepoSpy = DeleteFavouriteRepoSpy()
        deleteFavRepoStub = DeleteFavouriteThrowingStub()
    }

    func test_deleteFact_is_called() {
        XCTAssertFalse(deleteFavRepoSpy.deleteFavCalled)

        let sut = DeleteFavouriteUseCaseImplementation(deleteFavouriteRepository: deleteFavRepoSpy)
        try! sut.deleteFavourite(fact: Fact(text: "A Mock Fact"))
        XCTAssertTrue(deleteFavRepoSpy.deleteFavCalled)
    }

    func test_deleteFact_throws_error_when_deleting_fails() {
        let sut = DeleteFavouriteUseCaseImplementation(deleteFavouriteRepository: deleteFavRepoStub)
        XCTAssertThrowsError(try sut.deleteFavourite(fact: Fact(text: "A Mock Fact")))
    }
}

final class DeleteFavouriteRepoSpy: DeleteFactRepository {

    var deleteFavCalled: Bool = false

    func deleteFavourite(fact: Fact) throws {
        deleteFavCalled = true
    }
}

final class DeleteFavouriteThrowingStub: DeleteFactRepository {

    func deleteFavourite(fact: Fact) throws {
        throw LocalStoreError.factNotFound
    }
}
