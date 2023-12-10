import XCTest
@testable import Facto

final class FactRepositoryTest: XCTestCase {

    var sut: FactRepositoryImplementation!

    override func setUp() {
        sut = FactRepositoryImplementation(
            factService: FactServiceStub(sessionClient: HttpClientStub()),
            localStore: LocalStoreDummy()
        )
    }

    override func tearDown() {
        sut = nil
    }
    
    func test_getFact_returns_fact() async {
        let fact = try! await sut.getFact()

        XCTAssertEqual(fact.text, "test fact")
    }
}

final class FactServiceStub: FactService {
    
    override func getFact() async throws -> Fact {
        return Fact(text: "test fact")
    }
}

final class NetworkRequestStub: NetworkRequest {

    var path: String = ""
    var query: String = ""

    func getUrlRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: "www.google.com")!)
    }
}

final class HttpClientStub: HttpClient {

    func getResult(from urlRequest: URLRequest) async throws -> Data {
        let fileURL = Bundle(for: type(of: self)).url(forResource: "FactResponse", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        return data
    }
}

final class LocalStoreDummy: LocalStore {

    var storedFacts: [Fact]? = [Fact(text: "A Mock Fact")]

    func addFactToFavourites(fact: Fact) { }

    func removeFactFromFavourites(fact: Fact) { }
}
