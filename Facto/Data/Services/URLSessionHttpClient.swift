import Foundation

final class URLSessionHttpClient {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension URLSessionHttpClient: HttpClient {

    func getResult(from urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw NetworkError.statusError
            }
            return data

        } catch URLError.notConnectedToInternet {
            throw URLError(.notConnectedToInternet)
        }
    }
}
