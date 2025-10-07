import XCTest
@testable import MyAppName

@MainActor
final class DependencyContainerTests: XCTestCase {
    var container: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        container = DependencyContainer()
    }
    
    override func tearDown() {
        container = nil
        super.tearDown()
    }
    
    func testServicesInitialization() {
        XCTAssertNotNil(container.userService)
        XCTAssertNotNil(container.dataService)
        XCTAssertNotNil(container.networkService)
    }
    
    func testViewModelRegistration() {
        let viewModel = HomeViewModel(container: container)
        let key = "HomeViewModel"
        
        container.register(viewModel, for: key)
        let retrievedViewModel = container.resolve(HomeViewModel.self, for: key)
        
        XCTAssertNotNil(retrievedViewModel)
        XCTAssertTrue(retrievedViewModel === viewModel)
    }
    
    func testClearViewModels() {
        let viewModel = HomeViewModel(container: container)
        let key = "HomeViewModel"
        
        container.register(viewModel, for: key)
        XCTAssertNotNil(container.resolve(HomeViewModel.self, for: key))
        
        container.clearViewModels()
        XCTAssertNil(container.resolve(HomeViewModel.self, for: key))
    }
}
