import SwiftUI

@main
struct FactoApp: App {

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}

enum Screen: Hashable {
    case home
    case favourites
}
