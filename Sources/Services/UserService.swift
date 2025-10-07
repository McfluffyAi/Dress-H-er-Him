import Foundation

/// Service for managing user-related operations
@MainActor
class UserService: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private let dataService: DataService
    
    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }
    
    /// Login user with credentials
    func login(email: String, password: String) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Mock authentication logic
        if email == "test@example.com" && password == "password" {
            let user = User(id: UUID(), email: email, name: "Test User")
            currentUser = user
            isAuthenticated = true
            
            // Save user data
            try await dataService.saveUser(user)
        } else {
            throw AuthenticationError.invalidCredentials
        }
    }
    
    /// Logout current user
    func logout() async throws {
        currentUser = nil
        isAuthenticated = false
        try await dataService.clearUserData()
    }
    
    /// Get current user profile
    func getCurrentUser() async throws -> User? {
        return try await dataService.getCurrentUser()
    }
}

// MARK: - Models
struct User: Codable, Identifiable {
    let id: UUID
    let email: String
    let name: String
}

enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        case .networkError:
            return "Network connection failed"
        }
    }
}
