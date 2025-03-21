import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isAuthenticated, let token = viewModel.accessToken {
                MainTabView(accessToken: token)
                    .onAppear {
                        print(token)
                    }
            } else {
                let authURLString = "https://oauth.vk.com/authorize?client_id=" +
                "52954381&display=mobile&redirect_uri=https://"
                + "oauth.vk.com/blank.html&scope=friends,groups,photos&response_type=token&v=5.131"
                AuthWebView(url: URL(string: authURLString)!) { url in
                    viewModel.handleAuth(url: url)
                }

            }
        }
    }
}

#Preview {
    AuthView()
}
