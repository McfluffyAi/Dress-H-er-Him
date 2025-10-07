import Foundation
import SwiftUI

/// Base protocol for all ViewModels
@MainActor
protocol BaseViewModel: ObservableObject {
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    
    func handle(_ action: Action)
}

/// Base ViewModel implementation with common functionality
@MainActor
class ViewModel<State, Action>: BaseViewModel {
    @Published var state: State
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let container: DependencyContainer
    
    init(initialState: State, container: DependencyContainer) {
        self.state = initialState
        self.container = container
    }
    
    func handle(_ action: Action) {
        // Override in subclasses
    }
    
    /// Show loading state
    func setLoading(_ loading: Bool) {
        isLoading = loading
    }
    
    /// Show error message
    func setError(_ message: String?) {
        errorMessage = message
    }
    
    /// Clear error message
    func clearError() {
        errorMessage = nil
    }
    
    /// Execute async operation with loading state management
    func execute<T>(
        operation: @escaping () async throws -> T,
        onSuccess: @escaping (T) -> Void = { _ in },
        onError: @escaping (Error) -> Void = { _ in }
    ) {
        Task {
            setLoading(true)
            clearError()
            
            do {
                let result = try await operation()
                await MainActor.run {
                    setLoading(false)
                    onSuccess(result)
                }
            } catch {
                await MainActor.run {
                    setLoading(false)
                    setError(error.localizedDescription)
                    onError(error)
                }
            }
        }
    }
}
