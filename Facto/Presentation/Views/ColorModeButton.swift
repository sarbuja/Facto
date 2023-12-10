import SwiftUI

struct ColorModeButton: View {

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button {
            let color = AppSettings.shared.theme
            AppSettings.shared.theme = color == .light ? .dark : .light
        } label: {
            Image(systemName: "moonphase.first.quarter")
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct ColorModeButton_Previews: PreviewProvider {
    static var previews: some View {
        ColorModeButton()
    }
}
