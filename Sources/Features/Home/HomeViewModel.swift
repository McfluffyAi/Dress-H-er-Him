import Foundation
import SwiftUI

// MARK: - Home State
struct HomeState {
    var items: [HomeItem] = []
    var searchText: String = ""
    var selectedCategory: Category? = nil
    var isRefreshing: Bool = false
}

// MARK: - Home Actions
enum HomeAction {
    case loadItems
    case refreshItems
    case search(String)
    case selectCategory(Category?)
    case selectItem(HomeItem)
    case retry
}

// MARK: - Home ViewModel
@MainActor
class HomeViewModel: ViewModel<HomeState, HomeAction> {
    private let userService: UserService
    private let dataService: DataService
    
    init(container: DependencyContainer) {
        self.userService = container.userService
        self.dataService = container.dataService
        super.init(initialState: HomeState(), container: container)
    }
    
    func setup(container: DependencyContainer) {
        // Additional setup if needed
        handle(.loadItems)
    }
    
    override func handle(_ action: HomeAction) {
        switch action {
        case .loadItems:
            loadItems()
            
        case .refreshItems:
            refreshItems()
            
        case .search(let text):
            searchItems(text: text)
            
        case .selectCategory(let category):
            selectCategory(category)
            
        case .selectItem(let item):
            selectItem(item)
            
        case .retry:
            retry()
        }
    }
    
    private func loadItems() {
        execute(
            operation: {
                // Simulate loading items
                try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                return generateMockItems()
            },
            onSuccess: { [weak self] items in
                self?.state.items = items
            }
        )
    }
    
    private func refreshItems() {
        state.isRefreshing = true
        execute(
            operation: {
                try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                return generateMockItems()
            },
            onSuccess: { [weak self] items in
                self?.state.items = items
                self?.state.isRefreshing = false
            },
            onError: { [weak self] _ in
                self?.state.isRefreshing = false
            }
        )
    }
    
    private func searchItems(text: String) {
        state.searchText = text
        // Implement search logic here
    }
    
    private func selectCategory(_ category: Category?) {
        state.selectedCategory = category
        // Implement category filtering here
    }
    
    private func selectItem(_ item: HomeItem) {
        // Handle item selection
        print("Selected item: \(item.title)")
    }
    
    private func retry() {
        clearError()
        loadItems()
    }
    
    private func generateMockItems() -> [HomeItem] {
        return [
            HomeItem(id: UUID(), title: "Sample Item 1", description: "This is a sample item", category: .featured),
            HomeItem(id: UUID(), title: "Sample Item 2", description: "Another sample item", category: .new),
            HomeItem(id: UUID(), title: "Sample Item 3", description: "Yet another sample item", category: .trending)
        ]
    }
}

// MARK: - Supporting Models
struct HomeItem: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let category: Category
}

enum Category: String, CaseIterable, Codable {
    case featured = "Featured"
    case new = "New"
    case trending = "Trending"
    case popular = "Popular"
}
