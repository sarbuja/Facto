import SwiftUI

struct CoordinatorView: View {

    @StateObject var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: .home)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
        }
        .environmentObject(coordinator)
    }
}
