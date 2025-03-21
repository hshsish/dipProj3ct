
import XCTest
@testable import conch

class FriendsViewModel {
    private var networkService: NetworkServiceProtocol
    var friends: [Friend] = []
    var errorMessage: String?

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchFriends() {
        networkService.fetchFriends { result in
            switch result {
            case .success(let friends):
                self.friends = friends
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

