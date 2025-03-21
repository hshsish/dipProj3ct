
import XCTest
@testable import conch

final class PhotosViewModelTests: XCTestCase {
    var viewModel: PhotosViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = PhotosViewModel(accessToken: "mock_token")
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchPhotosFailure() {
        mockNetworkService.mockResponse = nil

        let expectation = self.expectation(description: "Ошибка загрузки фото")

        viewModel.fetchPhotos()

        DispatchQueue.main.async {
            XCTAssertTrue(self.viewModel.photos.isEmpty)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}
