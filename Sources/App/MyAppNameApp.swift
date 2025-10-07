import SwiftUI

@main
struct MyAppNameApp: App {
    @StateObject private var container = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(container)
        }
    }
}
