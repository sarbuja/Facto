import Foundation

protocol GetFactUseCase {
    func getFact() async throws -> Fact
}

struct GetFactUseCaseImplementation: GetFactUseCase {

    let getFactRepository: GetFactRepository

    init(repository: GetFactRepository) {
        getFactRepository = repository
    }

    func getFact() async throws -> Fact {
        try await getFactRepository.getFact()
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
