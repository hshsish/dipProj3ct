
import XCTest

final class PhotosViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testPhotosViewLoadsImages() throws {
        let photosTab = app.tabBars.buttons["Фото"]
        if photosTab.exists {
            photosTab.tap()
        }

        let firstImage = app.images.firstMatch
        XCTAssertTrue(firstImage.waitForExistence(timeout: 50), "Изображения не загрузились")
    }
}
