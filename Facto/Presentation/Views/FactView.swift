import SwiftUI

struct FactView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State private var showAlert: Bool = false

    @StateObject private var viewModel = {
        let factService = FactService(sessionClient: URLSessionHttpClient())
        let repository = FactRepositoryImplementation(factService: factService, localStore: FavouritesLocalStore())
        let getFactUseCase = GetFactUseCaseImplementation(repository: repository)
        let saveFactUseCase = SaveToFavouritesUseCaseImplementation(repository: repository)
        return FactViewModel(getFactUseCase: getFactUseCase, saveFactUseCase: saveFactUseCase)
    }()

    private var lottieViewSize: CGFloat {
        if horizontalSizeClass == .compact {
            return UIScreen.main.bounds.width * 0.8
        } else {
            return UIScreen.main.bounds.width * 0.5
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                CustomColor.background
                    .ignoresSafeArea()

                Group {
                    if viewModel.showLoading {
                        LottieView(lottieFile: "bulb-lottie")
                            .frame(width: lottieViewSize, height: lottieViewSize)
                    } else {
                        VStack {
                            Spacer()
                            Text(viewModel.fact?.text ?? "")
                                .font(.custom("AmericanTypewriter", size: 40))
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            Spacer()
                            HStack {
                                Spacer()
                                LoveFactButton(viewModel: viewModel)
                                Spacer()
                                NextFactButton(viewModel: viewModel)
                                Spacer()
                            }
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                }
                .onLoad {
                    Task {
                        await viewModel.getFact()
                    }
                }
                .onReceive(viewModel.$errorMessage.dropFirst(), perform: { _ in
                    showAlert = true
                })
                .alert(
                    "Something went wrong",
                    isPresented: $showAlert,
                    actions: {
                        // Do nothing yet. Just close the alert dialog which is done by default.
                    },
                    message: {
                        Text(viewModel.errorMessage)
                    }
                )
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        FavouritesButton()
                        ColorModeButton()
                    }
                }

                // Loving Animation
                if viewModel.showFavouriting {
                    LottieView(
                        lottieFile: "love-lottie",
                        mode: .playOnce,
                        action: {
                            viewModel.showFavouriting = false
                        }
                    )
                    .frame(width: lottieViewSize, height: lottieViewSize)
                }
            }
        }
    }
}

struct FactView_Previews: PreviewProvider {
    
    static var previews: some View {
        FactView()
    }
}
