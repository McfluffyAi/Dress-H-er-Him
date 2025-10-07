import Foundation

/// Dependency injection container for managing app-wide dependencies
@MainActor
class DependencyContainer: ObservableObject {
    // MARK: - Services
    private(set) lazy var userService = UserService()
    private(set) lazy var dataService = DataService()
    private(set) lazy var networkService = NetworkService()
    
    // MARK: - ViewModels
    private var viewModels: [String: Any] = [:]
    
    /// Register a view model instance
    func register<T>(_ viewModel: T, for key: String) {
        viewModels[key] = viewModel
    }
    
    /// Retrieve a registered view model
    func resolve<T>(_ type: T.Type, for key: String) -> T? {
        return viewModels[key] as? T
    }
    
    /// Clear all registered view models
    func clearViewModels() {
        viewModels.removeAll()
    }
}
