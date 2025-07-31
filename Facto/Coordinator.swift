import SwiftUI

@MainActor
class Coordinator: ObservableObject {

    @Published var path: NavigationPath = NavigationPath()
    private let factViewModel: FactViewModel
    private let favouritesViewModel: FavouritesViewModel

    init(factService: FactService = FactService(), localStore: FavouritesLocalStore = FavouritesLocalStore()) {
        let factService = factService
        let repository = FactRepositoryImplementation(factService: factService, localStore: localStore)
        let getFactUseCase = GetFactUseCaseImplementation(factRepository: repository)
        let saveFactUseCase = SaveToFavouritesUseCaseImplementation(factRepository: repository)
        factViewModel = FactViewModel(getFactUseCase: getFactUseCase, saveFactUseCase: saveFactUseCase)

        let deleteFactUseCase = DeleteFavouriteUseCaseImplementation(factRepository: repository)
        favouritesViewModel = FavouritesViewModel(localStore: localStore, deleteFactUseCase: deleteFactUseCase)
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .home:
            FactView(viewModel: factViewModel)
        case .favourites:
            FavouritesView(viewModel: favouritesViewModel)
        }
    }

    func pushToScreen(screen: Screen) {
        path.append(screen)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
