import SwiftUI

struct FavouritesView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State private var searchText = ""
    @ObservedObject var viewModel: FavouritesViewModel

    private var lottieViewSize: CGFloat {
        if horizontalSizeClass == .compact {
            return UIScreen.main.bounds.width * 0.8
        } else {
            return UIScreen.main.bounds.width * 0.5
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.primary
                .ignoresSafeArea()

            Group {
                if let facts = viewModel.facts, facts.isEmpty {
                    VStack {
                        Spacer()
                        Text("No favourites")
                            .font(.custom("AmericanTypewriter", size: 22))
                        LottieView(lottieFile: "not-found-lottie")
                            .frame(width: lottieViewSize, height: lottieViewSize)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(viewModel.facts ?? []) { fact in
                            Section {
                                Text(fact.text)
                                    .font(.custom("AmericanTypewriter", size: 22))
                            }
                        }
                        .onDelete(perform: deleteFact(offsets:))
                    }
//                    .animation(.default, value: viewModel.facts)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search your favourites")
            .onChange(of: searchText) { _ in
                viewModel.filterFacts(text: searchText)
            }
            .scrollContentBackground(.hidden)
            .onAppear() {
                viewModel.getFacts()
            }
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ColorModeButton()
//            }
        }
    }

    private func deleteFact(offsets: IndexSet) {
        withAnimation {
            let factsToDelete = offsets.compactMap { viewModel.facts?[$0] }
            factsToDelete.forEach { viewModel.removeFact(fact: $0) }
        }
    }
}
//
//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            FavouritesView()
//            FavouritesView(viewModel: FavouritesViewModel(localStore: PreviewsFavouriteStore()))
//        }
//    }
//}
