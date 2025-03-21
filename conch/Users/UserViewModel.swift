import Foundation
import Combine

class UserViewModel: ObservableObject {

    @Published var user: User?
    @Published var errorMessage: String?
    @Published var showingError: Bool = false

    private let accessToken: String
    private let userId: Int?

    init(accessToken: String, userId: Int? = nil) {
        self.accessToken = accessToken
        self.userId = userId
        fetchUserProfile()
    }

    func fetchUserProfile() {
        let baseUrl = "https://api.vk.com/method/users.get?fields=photo_200"
        let userQuery = userId != nil ? "&user_ids=\(userId!)" : ""
        let urlString = "\(baseUrl)\(userQuery)&access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [User]?) in
            DispatchQueue.main.async {
                if let user = response?.first {
                    self.user = user
                } else {
                    self.showError("Ошибка при получении данных пользователя")
                }
            }
        }
    }

    private func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showingError = true
        }
    }
}
