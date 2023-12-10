import SwiftUI

class AppSettings: ObservableObject {

    static let shared = AppSettings()

    @AppStorage("color_scheme") var theme: ColorScheme = .light

    private init() {}
}
