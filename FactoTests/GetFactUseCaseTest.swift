import XCTest
@testable import Facto

final class GetFactUseCaseTest: XCTestCase {

    var repoSpy: GetFactRepositorySpy!
    var repoStub: GetFactRepositoryThrowingStub!

    override func setUp() {
        super.setUp()
        repoSpy = GetFactRepositorySpy()
        repoStub = GetFactRepositoryThrowingStub()
    }

    override func tearDown() {
        repoSpy = nil
        repoStub = nil
        super.tearDown()
    }

    func test_getFact_is_called() async {
        XCTAssertFalse(repoSpy.getFactCalled)

        let sut = GetFactUseCaseImplementation(repository: repoSpy)
        _ = try! await sut.getFact()
        XCTAssertTrue(repoSpy.getFactCalled)
    }

    func test_getFact_throws_error_when_fetching_fails() async {
        let sut = GetFactUseCaseImplementation(repository: repoStub)

        await XCTAssertThrowsErrorAsync(try await sut.getFact())
    }
}

final class GetFactRepositorySpy: GetFactRepository {

    var getFactCalled = false

    func getFact() async throws -> Fact {
        getFactCalled = true
        return Fact(text: "test fact")
    }
}

final class GetFactRepositoryThrowingStub: GetFactRepository {

    func getFact() async throws -> Fact {
        throw NetworkError.statusError
    }
}
