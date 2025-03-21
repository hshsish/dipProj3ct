
import XCTest
@testable import conch

final class DataManagerTests: XCTestCase {
    var dataManager: DataManager!

    override func setUp() {
        super.setUp()
        dataManager = DataManager()
    }

    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }

    func testSaveAndFetchGroups() {
        let testGroups = [Group(id: 1, name: "Test Group")]
        dataManager.saveGroups(testGroups)

        let fetchedGroups = dataManager.fetchGroups()
        XCTAssertEqual(fetchedGroups.count, 1)
        XCTAssertEqual(fetchedGroups.first?.name, "Test Group")
    }
}
