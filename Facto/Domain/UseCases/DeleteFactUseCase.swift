import Foundation

protocol DeleteFactUseCase {
    func deleteFavourite(fact: Fact) throws
}

struct DeleteFavouriteUseCaseImplementation: DeleteFactUseCase {

    let factRepository: FactRepository

    func deleteFavourite(fact: Fact) throws {
        try factRepository.deleteFavourite(fact: fact)
    }
}
