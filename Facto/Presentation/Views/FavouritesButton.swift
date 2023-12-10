import SwiftUI

struct FavouritesButton: View {

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationLink {
            FavouritesView()
        } label: {
            Image(systemName: "list.clipboard.fill")
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct FavouritesButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesButton()
    }
}
