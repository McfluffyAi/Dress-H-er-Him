import Foundation
import SwiftUI

// MARK: - Login State
struct LoginState {
    var isAuthenticated = false
}

// MARK: - Login Actions
enum LoginAction {
    case login(email: String, password: String)
    case logout
    case retry
}

// MARK: - Login ViewModel
@MainActor
class LoginViewModel: ViewModel<LoginState, LoginAction> {
    private let userService: UserService
    
    init(container: DependencyContainer) {
        self.userService = container.userService
        super.init(initialState: LoginState(), container: container)
    }
    
    func setup(container: DependencyContainer) {
        // Check if user is already authenticated
        Task {
            if let user = try await userService.getCurrentUser() {
                state.isAuthenticated = true
            }
        }
    }
    
    override func handle(_ action: LoginAction) {
        switch action {
        case .login(let email, let password):
            login(email: email, password: password)
            
        case .logout:
            logout()
            
        case .retry:
            retry()
        }
    }
    
    private func login(email: String, password: String) {
        execute(
            operation: {
                try await userService.login(email: email, password: password)
            },
            onSuccess: { [weak self] _ in
                self?.state.isAuthenticated = true
            }
        )
    }
    
    private func logout() {
        execute(
            operation: {
                try await userService.logout()
            },
            onSuccess: { [weak self] _ in
                self?.state.isAuthenticated = false
            }
        )
    }
    
    private func retry() {
        clearError()
    }
}
