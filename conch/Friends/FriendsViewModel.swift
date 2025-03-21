import SwiftUI

class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []
    @Published var selectedFriend: Friend?
    @Published var errorMessage: String?
    @Published var showingError = false
    @Published var isLoading: Bool = false

     let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
        loadFriends()
    }

    func loadFriends() {
        friends = DataManager.shared.fetchFriends()
        fetchFriends()
    }

    func fetchFriends() {
        isLoading = true
        let urlString = "https://api.vk.com/method/friends.get?fields" +
        "=first_name,last_name,online&access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [Friend]?) in
            DispatchQueue.main.async {
                self.isLoading = false
                if let response = response {
                    self.friends = response
                    DataManager.shared.saveFriends(response)
                } else {
                    self.showError("Ошибка при получении данных друзей")
                }
            }
        }
    }

    private func showError(_ message: String) {
        errorMessage = message
        showingError = true
    }
}
