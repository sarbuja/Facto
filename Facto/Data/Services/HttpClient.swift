import Foundation

protocol HttpClient {
    func getResult(from urlRequest: URLRequest) async throws -> Data
}
