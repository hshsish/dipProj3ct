
import Foundation
@testable import conch

class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: Any?

    func fetchData<T: Decodable>(_ urlString: String, completion: @escaping (T?) -> Void) {
        completion(mockResponse as? T)
    }
    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        if let friends = mockResponse as? [Friend] {
            completion(.success(friends))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No friends available"])))
        }
    }
}

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(_ urlString: String, completion: @escaping (T?) -> Void)
    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void)
}
