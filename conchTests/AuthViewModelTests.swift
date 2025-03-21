
import XCTest
@testable import conch

class AuthViewModelTests: XCTestCase {

    var viewModel: AuthViewModel!

    override func setUp() {
        super.setUp()
        viewModel = AuthViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testExtractToken_InvalidURL() {
        let url = "https://oauth.vk.com/blank.html#no_token_here"
        viewModel.handleAuth(url: url)
        
        XCTAssertNil(viewModel.accessToken)
        XCTAssertFalse(viewModel.isAuthenticated)
    }

    func testExtractToken_EmptyString() {
        viewModel.handleAuth(url: "")
        
        XCTAssertNil(viewModel.accessToken)
        XCTAssertFalse(viewModel.isAuthenticated)
    }
}
