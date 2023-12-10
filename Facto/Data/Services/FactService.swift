import Foundation

class FactService {
    let sessionClient: HttpClient
    let factRequest: FactRequest

    init(sessionClient: HttpClient, factRequest: FactRequest = FactRequest(limit: 1)) {
        self.sessionClient = sessionClient
        self.factRequest = factRequest
    }

    func getFact() async throws -> Fact {
        do {
            let data = try await sessionClient.getResult(from: factRequest.getUrlRequest())

            guard let facts = try? JSONDecoder().decode([FactDTO].self, from: data),
                  let factDTO = facts.first else {
                throw NetworkError.decodingError
            }
            return getMappedModel(dto: factDTO)
        } catch NetworkError.statusError {
            throw NetworkError.statusError
        }
    }

    private func getMappedModel(dto: FactDTO) -> Fact {
        return Fact(text: dto.fact)
    }
}
