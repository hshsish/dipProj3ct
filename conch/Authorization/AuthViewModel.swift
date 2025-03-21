import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var accessToken: String?

    func handleAuth(url: String) {
        if let token = extractToken(from: url) {
            DispatchQueue.main.async {
                self.accessToken = token
                self.isAuthenticated = true
            }
        }
    }

    private func extractToken(from url: String) -> String? {
        if let fragment = URL(string: url)?.fragment {
            let params = fragment.split(separator: "&").reduce(into: [String: String]()) {
                let pair = $1.split(separator: "=")
                if pair.count == 2 { $0[String(pair[0])] = String(pair[1]) }
            }
            return params["access_token"]
        }
        return nil
    }
}
