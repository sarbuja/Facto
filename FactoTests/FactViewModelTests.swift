import XCTest
@testable import Facto

final class FactViewModelTests: XCTestCase {

    @MainActor
    func test_getFact_is_called() async {
        let getFactUseCaseSpy = GetFactUseCaseSpy()
        let saveFactUseCaseSpy = SaveFactUseCaseSpy()
        let sut = FactViewModel(getFactUseCase: getFactUseCaseSpy, saveFactUseCase: saveFactUseCaseSpy)
        XCTAssertFalse(getFactUseCaseSpy.isGetFactCalled)

        await sut.getFact()
        XCTAssertTrue(getFactUseCaseSpy.isGetFactCalled)
    }

    @MainActor
    func test_saveFact_is_called() async {
        let getFactUseCaseSpy = GetFactUseCaseSpy()
        let saveFactUseCaseSpy = SaveFactUseCaseSpy()
        let sut = FactViewModel(getFactUseCase: getFactUseCaseSpy, saveFactUseCase: saveFactUseCaseSpy)
        XCTAssertFalse(saveFactUseCaseSpy.isSaveFactCalled)

        try! sut.saveFactToFavourites(fact: Fact(text: "A Spy fact"))
        XCTAssertTrue(saveFactUseCaseSpy.isSaveFactCalled)
    }

    @MainActor
    func test_errorMessage_is_populated_when_fetching_fails() async {
        let sut = FactViewModel(getFactUseCase: GetFactUseCaseWithErrorStub(), saveFactUseCase: SaveFactUseCaseDummy())

        await sut.getFact()

        XCTAssertEqual(sut.errorMessage, NetworkError.statusError.localizedDescription)
    }

    @MainActor
    func test_dummy_fact_is_populated_after_successful_fetching() async {
        let sut = FactViewModel(getFactUseCase: GetFactUseCaseWithFactStub(), saveFactUseCase: SaveFactUseCaseDummy())

        await sut.getFact()

        XCTAssertEqual(sut.fact?.text, "A Stub fact")
    }

    @MainActor
    func test_remove_fact() {

    }
}

final class GetFactUseCaseWithErrorStub: GetFactUseCase {

    func getFact() async throws -> Fact {
        throw NetworkError.statusError
    }
}

final class SaveFactUseCaseDummy: SaveFactUseCase {

    func saveFactToFavourites(fact: Fact) { }
}

final class GetFactUseCaseWithFactStub: GetFactUseCase {

    func getFact() async throws -> Fact {
        return Fact(text: "A Stub fact")
    }
}

final class GetFactUseCaseSpy: GetFactUseCase {

    var isGetFactCalled = false

    func getFact() async throws -> Fact {
        isGetFactCalled = true

        return Fact(text: "test fact *")
    }
}

final class SaveFactUseCaseSpy: SaveFactUseCase {

    var isSaveFactCalled = false

    func saveFactToFavourites(fact: Fact) {
        isSaveFactCalled = true
    }
}
