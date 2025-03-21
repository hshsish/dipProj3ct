import Foundation
import Combine

class GroupViewModel: ObservableObject {
    @Published var groups: [Group] = []
    @Published var errorMessage: String?
    @Published var showingError: Bool = false
    @Published var errorDate: String?

    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
        loadGroups()
    }

    func loadGroups() {
        groups = DataManager.shared.fetchGroups()
        fetchGroups()
    }

    func fetchGroups() {
        let urlString = "https://api.vk.com/method/groups.get?extended=1&access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [Group]?) in
            if let response = response {
                DispatchQueue.main.async {
                    self.groups = response
                    DataManager.shared.saveGroups(response)
                }
            } else {
                self.showError("Ошибка при получении данных групп")
            }
        }
    }

    private func showError(_ message: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        errorDate = dateFormatter.string(from: Date())

        DispatchQueue.main.async {
            self.errorMessage = message
            self.showingError = true
        }
    }
}
