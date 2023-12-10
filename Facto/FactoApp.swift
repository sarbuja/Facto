import SwiftUI

@main
struct FactoApp: App {

    @StateObject var appSettings = AppSettings.shared

    var body: some Scene {
        WindowGroup {
            FactView()
                .preferredColorScheme(appSettings.theme)
        }
    }
}
