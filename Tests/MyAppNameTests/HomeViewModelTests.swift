import XCTest
@testable import MyAppName

@MainActor
final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var container: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        container = DependencyContainer()
        viewModel = HomeViewModel(container: container)
    }
    
    override func tearDown() {
        viewModel = nil
        container = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.state.items.isEmpty)
        XCTAssertEqual(viewModel.state.searchText, "")
        XCTAssertNil(viewModel.state.selectedCategory)
        XCTAssertFalse(viewModel.state.isRefreshing)
    }
    
    func testLoadItems() {
        let expectation = XCTestExpectation(description: "Items loaded")
        
        viewModel.handle(.loadItems)
        
        // Wait for async operation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            XCTAssertFalse(self.viewModel.state.items.isEmpty)
            XCTAssertEqual(self.viewModel.state.items.count, 3)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testSearch() {
        let searchText = "test search"
        viewModel.handle(.search(searchText))
        
        XCTAssertEqual(viewModel.state.searchText, searchText)
    }
    
    func testSelectCategory() {
        let category = Category.featured
        viewModel.handle(.selectCategory(category))
        
        XCTAssertEqual(viewModel.state.selectedCategory, category)
    }
    
    func testDeselectCategory() {
        let category = Category.featured
        viewModel.handle(.selectCategory(category))
        viewModel.handle(.selectCategory(category)) // Select same category again
        
        XCTAssertNil(viewModel.state.selectedCategory)
    }
}
