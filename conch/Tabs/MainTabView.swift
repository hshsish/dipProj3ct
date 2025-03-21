import SwiftUI

struct MainTabView: View {
    let accessToken: String
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var viewModel: MainTabViewModel

    init(accessToken: String) {
          self.accessToken = accessToken
          _viewModel = StateObject(wrappedValue: MainTabViewModel(accessToken: accessToken))
      }

    var body: some View {
        TabView {
            FriendsView(accessToken: accessToken)
                .tabItem {
                    Label("Друзья", systemImage: "person.2")
                }
            GroupsView(accessToken: accessToken)
                .tabItem {
                    Label("Группы", systemImage: "person.3")
                }
            PhotosView(accessToken: accessToken)
                .tabItem {
                    Label("Фото", systemImage: "photo")
                }
            UserProfileView(accessToken: accessToken, themeManager: themeManager)
                .tabItem {
                    Label("Профиль", systemImage: "person.circle")
                }
        }
        .accentColor(themeColor)
        .preferredColorScheme(themeManager.theme == .dark ? .dark : .light)
    }

    private var themeColor: Color {
        switch themeManager.theme {
        case .dark: return .white
        case .pink: return .pink
        default: return .black
        }
    }
}
