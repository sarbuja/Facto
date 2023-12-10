import Foundation

protocol DeleteFactUseCase {
    func deleteFavourite(fact: Fact) throws
}

struct DeleteFavouriteUseCaseImplementation: DeleteFactUseCase {

    let deleteFavouriteRepository: DeleteFactRepository
    
    func deleteFavourite(fact: Fact) throws {
        try deleteFavouriteRepository.deleteFavourite(fact: fact)
    }
}
