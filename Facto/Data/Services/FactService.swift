import Foundation

class FactService {
    let sessionClient: HttpClient
    let factRequest: FactRequest

    init(sessionClient: HttpClient = URLSessionHttpClient(), factRequest: FactRequest = FactRequest()) {
        self.sessionClient = sessionClient
        self.factRequest = factRequest
    }

    func getFact() async throws -> Fact {
        do {
            let data = try await sessionClient.getResult(from: factRequest.getUrlRequest())

            guard let facts = try? JSONDecoder().decode([Fact].self, from: data),
                  let fact = facts.first else {
                throw NetworkError.decodingError
            }
            return fact
        } catch NetworkError.statusError {
            throw NetworkError.statusError
        }
    }
}
