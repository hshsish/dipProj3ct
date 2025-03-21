
import XCTest
@testable import conch

class MockDataManager: DataManagerProtocol {
    var mockGroups: [Group]?
    var shouldReturnError = false

    func fetchGroups(completion: @escaping ([Group]?) -> Void) {
        if shouldReturnError {
            completion(nil)
        } else {
            completion(mockGroups)
        }
    }
    
    func saveGroups(_ groups: [Group]) {
    }
}

protocol DataManagerProtocol {
    func fetchGroups(completion: @escaping ([Group]?) -> Void)
    func saveGroups(_ groups: [Group])
}
