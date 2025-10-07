import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var container: DependencyContainer
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingLogin = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Welcome Section
                VStack(spacing: 12) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                    
                    Text("Welcome to MyAppName")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Your iOS 17 SwiftUI app is ready!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Quick Actions
                VStack(spacing: 16) {
                    Button(action: {
                        showingLogin = true
                    }) {
                        HStack {
                            Image(systemName: "person.circle")
                            Text("Login")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        // Add your action here
                    }) {
                        HStack {
                            Image(systemName: "star.fill")
                            Text("Get Started")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // App Info
                VStack(spacing: 8) {
                    Text("iOS 17 • SwiftUI • MVVM")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Built with modern Swift practices")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 20)
            }
            .padding()
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            viewModel.setup(container: container)
        }
        .sheet(isPresented: $showingLogin) {
            LoginView()
                .environmentObject(container)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DependencyContainer())
}
