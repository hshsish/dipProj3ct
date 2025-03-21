import Foundation
import Combine

class MainTabViewModel: ObservableObject {
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
        fetchAndSaveUserData()
    }

    func fetchAndSaveUserData() {
        fetchAndSaveUserName()
        fetchAndSaveFriends()
        fetchAndSaveGroups()
    }

    private func fetchAndSaveUserName() {
        let urlString = "https://api.vk.com/method/users.get?fields=first_name," +
        "last_name&access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [User]?) in
            DispatchQueue.main.async {
                if let user = response?.first {
                    let fullName = "\(user.firstName) \(user.lastName)"
                    DataManager.shared.saveUser(name: fullName)
                    print("User saved: \(fullName)")
                } else {
                    print("Ошибка при получении данных пользователя")
                }
            }
        }
    }

    private func fetchAndSaveFriends() {
        let urlString = "https://api.vk.com/method/friends.get?fields=first_name," +
        "last_name,online&access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [Friend]?) in
            DispatchQueue.main.async {
                if let friends = response {
                    DataManager.shared.saveFriends(friends)
                    print("Friends saved")
                } else {
                    print("Ошибка при получении данных друзей")
                }
            }
        }
    }

    private func fetchAndSaveGroups() {
        let urlString = "https://api.vk.com/method/groups.get?extended=1&access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [Group]?) in
            DispatchQueue.main.async {
                if let groups = response {
                    DataManager.shared.saveGroups(groups)
                    print("Groups saved")
                } else {
                    print("Ошибка при получении данных групп")
                }
            }
        }
    }
}
