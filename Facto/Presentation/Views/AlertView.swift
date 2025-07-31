import SwiftUI

struct AlertView: View {

    let title: String
    let message: String
    @Binding var isPresented: Bool
    let action: (() -> Void)?

    var body: some View {
        ZStack {
            CustomBackgroundView()

            VStack {
                Spacer()
                Text(title)
                    .fontWeight(.black)
                    .font(.system(size: 52))
                    .foregroundStyle(.gray)

                Text(message)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)

                Spacer()

                Button {
                    isPresented = false
                    action?()
                } label: {
                    Text("OK")
                        .fontWeight(.heavy)
                        .foregroundStyle(.gray)
                        .font(.system(.largeTitle))
                }
                Spacer()
            }
        }
        .frame(width: 320, height: 250)
    }
}

struct CustomBackgroundView: View {
    var body: some View {
        ZStack {
            Color(R.color.greenDark)
                .cornerRadius(40)
                .offset(y: 12)

            Color(R.color.greenLight)
                .cornerRadius(40)
                .offset(y: 3)
                .opacity(0.85)

            LinearGradient(colors: [Color(R.color.greenLight), Color(R.color.greenMedium)],
                           startPoint: .top,
                           endPoint: .bottom)
            .cornerRadius(40)
        }
    }
}

struct AlertView_Previews: PreviewProvider {

    static var previews: some View {
        AlertView(title: "OOPS", message: "This has already been favourited", isPresented: .constant(true), action: {})
    }
}
