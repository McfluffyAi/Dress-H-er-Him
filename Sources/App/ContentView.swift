import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var container: DependencyContainer
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            HomeView()
                .environmentObject(viewModel)
        }
        .onAppear {
            viewModel.setup(container: container)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DependencyContainer())
}
