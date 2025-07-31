import SwiftUI

extension View {

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }

    func customAlert(title: String, message: String, isPresented: Binding<Bool>, action: (() -> Void)? = nil) -> some View {
        self.modifier(CustomAlertModifier(title: title, message: message, action: action, isPresented: isPresented))
    }
}
