import XCTest
@testable import Facto

final class HttpClientTest: XCTestCase {

    func test_get_result() async {
        let sut = HttpClientStatus200Stub()
        let result = try! await sut.getResult(from: URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertNotNil(result)
    }

//    func test_throw_error_when_status_fails() async {
//        let sut = HttpClientStatusNot200Stub()
//        await XCTAssertThrowsErrorAsync(try! await sut.getResult(from: URLRequest(url: URL(string: "www.google.com")!)))
//    }

}

final class HttpClientStatus200Stub: HttpClient {

    func getResult(from urlRequest: URLRequest) async throws -> Data {
        let fileURL = Bundle(for: type(of: self)).url(forResource: "FactResponse", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        return data
    }
}

final class HttpClientStatusNot200Stub: HttpClient {

    func getResult(from urlRequest: URLRequest) async throws -> Data {
        throw NetworkError.statusError
    }
}
