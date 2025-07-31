import SwiftUI

struct AlertView: View {

    let title: String?
    let message: String
    @Binding var isPresented: Bool
    let action: (() -> Void)?

    var body: some View {
        VStack(spacing: 10) {
            if let title {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.custom("AmericanTypewriter", size: 40))
            }

            Text(message)
                .foregroundStyle(.white)
                .font(.custom("AmericanTypewriter", size: 20))

            Spacer()
                .frame(height: 20)

            Button {
                isPresented = false
                action?()
            } label: {
                Text("OK")
                    .foregroundStyle(.white)
                    .font(.system(.largeTitle))
            }

        }
        .padding(20)
        .background(Color.secondary)
    }
}

struct AlertView_Previews: PreviewProvider {

    static var previews: some View {
        AlertView(title: "OOPS", message: "This has already been favourited", isPresented: .constant(true), action: {})
    }
}
