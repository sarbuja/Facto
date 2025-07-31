import SwiftUI

struct FavouritesButton: View {

//    @Environment(\.colorScheme) var colorScheme
    var tapAction: (() -> Void)?

    var body: some View {
        Button {
            tapAction?()
        } label: {
            Image(systemName: "list.clipboard.fill")
                .foregroundStyle(.white)
        }
    }
}

struct FavouritesButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesButton(tapAction: nil)
    }
}
