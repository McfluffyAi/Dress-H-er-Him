import XCTest
@testable import MyAppName

@MainActor
final class UserServiceTests: XCTestCase {
    var userService: UserService!
    var dataService: DataService!
    
    override func setUp() {
        super.setUp()
        dataService = DataService()
        userService = UserService(dataService: dataService)
    }
    
    override func tearDown() {
        userService = nil
        dataService = nil
        super.tearDown()
    }
    
    func testLoginSuccess() async throws {
        let email = "test@example.com"
        let password = "password"
        
        try await userService.login(email: email, password: password)
        
        XCTAssertTrue(userService.isAuthenticated)
        XCTAssertNotNil(userService.currentUser)
        XCTAssertEqual(userService.currentUser?.email, email)
    }
    
    func testLoginFailure() async throws {
        let email = "wrong@example.com"
        let password = "wrongpassword"
        
        do {
            try await userService.login(email: email, password: password)
            XCTFail("Login should have failed")
        } catch {
            XCTAssertFalse(userService.isAuthenticated)
            XCTAssertNil(userService.currentUser)
        }
    }
    
    func testLogout() async throws {
        // First login
        try await userService.login(email: "test@example.com", password: "password")
        XCTAssertTrue(userService.isAuthenticated)
        
        // Then logout
        try await userService.logout()
        XCTAssertFalse(userService.isAuthenticated)
        XCTAssertNil(userService.currentUser)
    }
}
