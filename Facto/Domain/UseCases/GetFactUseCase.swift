import Foundation

protocol GetFactUseCase {
    func getFact() async throws -> Fact
}

struct GetFactUseCaseImplementation: GetFactUseCase {

    let factRepository: FactRepository

    func getFact() async throws -> Fact {
        try await factRepository.getFact()
    }
}

// MARK: - Previews

struct PreviewGetFactUseCase: GetFactUseCase {

    func getFact() async throws -> Fact {
        return Fact(text: "")
    }
}

struct PreviewGetFactUseCaseTwo: GetFactUseCase {

    func getFact() async throws -> Fact {
        return Fact(text: "Hello World is my name.")
    }
}
