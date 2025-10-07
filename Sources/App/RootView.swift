import SwiftUI

struct RootView: View {
    @EnvironmentObject private var container: DependencyContainer
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(1)
        }
        .accentColor(.blue)
        .onAppear {
            setupApp()
        }
    }
    
    private func setupApp() {
        // Initialize app-wide services and configurations
        // This runs when the app first launches
    }
}

#Preview {
    RootView()
        .environmentObject(DependencyContainer())
}
