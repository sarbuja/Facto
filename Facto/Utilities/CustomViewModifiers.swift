import SwiftUI

struct ViewDidLoadModifier: ViewModifier {

    @State private var viewDidLoad = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if !viewDidLoad {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

struct CustomAlertModifier: ViewModifier {

    let title: String?
    let message: String
    let action: (() -> Void)?

    @State private var showAlert = false
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                AlertView(title: title, message: message, isPresented: $isPresented, action: {
                    withAnimation {
                        showAlert = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isPresented = false
                            action?()
                        }
                    }
                })
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .scaleEffect(showAlert ? 1 : 0.8)
                .opacity(showAlert ? 1 : 0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showAlert)
                .onAppear {
                    withAnimation {
                        showAlert = true
                    }
                }
            }
        }

    }
}
