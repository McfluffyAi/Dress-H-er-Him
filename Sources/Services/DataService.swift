import Foundation

/// Service for managing local data persistence
@MainActor
class DataService: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let userKey = "current_user"
    
    /// Save user data to local storage
    func saveUser(_ user: User) async throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        userDefaults.set(data, forKey: userKey)
    }
    
    /// Get current user from local storage
    func getCurrentUser() async throws -> User? {
        guard let data = userDefaults.data(forKey: userKey) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: data)
    }
    
    /// Clear user data from local storage
    func clearUserData() async throws {
        userDefaults.removeObject(forKey: userKey)
    }
    
    /// Save generic data
    func save<T: Codable>(_ object: T, forKey key: String) async throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        userDefaults.set(data, forKey: key)
    }
    
    /// Load generic data
    func load<T: Codable>(_ type: T.Type, forKey key: String) async throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
