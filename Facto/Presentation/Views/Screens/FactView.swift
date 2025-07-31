import SwiftUI
import RswiftResources

struct FactView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var coordinator: Coordinator

    @ObservedObject var viewModel: FactViewModel
    @State private var showAlert: Bool = false
    @State private var isPresented: Bool = false

    private var lottieViewSize: CGFloat {
        if horizontalSizeClass == .compact {
            return UIScreen.main.bounds.width * 0.8
        } else {
            return UIScreen.main.bounds.width * 0.5
        }
    }

    var body: some View {
        NavigationStack() {
            ZStack {
                Color(R.color.greenDefault)
                    .ignoresSafeArea()

                Group {
                    if viewModel.showLoading {
                        LottieView(resource: R.file.bulbLottieJson)
                            .frame(width: lottieViewSize, height: lottieViewSize)
                    } else {
                        VStack {
                            Spacer()
                            Text(viewModel.fact?.text ?? "")
                                .font(.custom("AmericanTypewriter", size: 40))
                                .foregroundStyle(Color.white)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            Spacer()
                            LoveFactButton(viewModel: viewModel)
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
                    isPresented = true
                })
                .customAlert(title: "OOPS", message: viewModel.errorMessage, isPresented: $isPresented)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        FavouritesButton {
                            coordinator.pushToScreen(screen: .favourites)
                        }
                    }
                }

                // Loving Animation
                if viewModel.showFavouriting {
                    LottieView(
                        resource: R.file.loveLottieJson,
                        mode: .playOnce,
                        action: {
                            viewModel.showFavouriting = false
                        }
                    )
                    .frame(width: lottieViewSize, height: lottieViewSize)
                }
            }
            .gesture(DragGesture()
                .onEnded({ value in
                    if value.translation.width < 0 {
                        Task {
                            await viewModel.getFact()
                        }
                    }
                }))
        }
    }
}

//struct FactView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FactView(coordinator: Coordinator(), viewModel: FactViewModel(getFactUseCase: <#any GetFactUseCase#>, saveFactUseCase: <#any SaveFactUseCase#>))
//    }
//}
