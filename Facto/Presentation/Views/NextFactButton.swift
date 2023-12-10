import SwiftUI

struct NextFactButton: View {

    @ObservedObject var viewModel: FactViewModel

    var body: some View {
        Button {
            Task {
                await viewModel.getFact()
            }
        } label: {
            Image(systemName: "arrowshape.right")
                .font(.largeTitle)
                .bold()
        }
    }
}

struct NextFactButton_Previews: PreviewProvider {

    static var previews: some View {
        return NextFactButton(
            viewModel: FactViewModel(
                getFactUseCase: PreviewGetFactUseCase(),
                saveFactUseCase: PreviewSaveFactUseCase()
            )
        )
    }
}
