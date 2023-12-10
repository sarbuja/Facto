import SwiftUI

struct LoveFactButton: View {

    @ObservedObject var viewModel: FactViewModel
    
    var body: some View {
        Button {
            do {
                try viewModel.saveFactToFavourites(fact: viewModel.fact ?? Fact(text: ""))
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } catch {
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        } label: {
            Image(systemName: "heart")
                .font(.largeTitle)
                .bold()
        }
    }
}

struct LoveFactButton_Previews: PreviewProvider {

    static var previews: some View {
        LoveFactButton(viewModel: FactViewModel(
            getFactUseCase: PreviewGetFactUseCase(),
            saveFactUseCase: PreviewSaveFactUseCase()
        ))
    }
}
