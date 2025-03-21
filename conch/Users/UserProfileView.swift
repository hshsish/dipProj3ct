import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel: UserViewModel
    @ObservedObject var themeManager: ThemeManager

    init(accessToken: String, themeManager: ThemeManager) {
        _viewModel = StateObject(wrappedValue: UserViewModel(accessToken: accessToken))
        self.themeManager = themeManager
    }

    var body: some View {
        VStack {
            if let user = viewModel.user {
                VStack {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.title)
                        .padding()
                        .foregroundColor(themeColor)

                    if let photoUrl = user.photoUrl, let url = URL(string: photoUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                    }
                }
                .padding()
                .background(themeBackground)
                .cornerRadius(15)
            } else {
                ProgressView()
            }

            Picker("Тема", selection: $themeManager.theme) {
                Text("Светлая").tag(Theme.light)
                Text("Тёмная").tag(Theme.dark)
                Text("Розовая").tag(Theme.pink)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .background(themeManager.theme == .dark ? Color.black : Color.white)
        .navigationTitle("Профиль")
        .alert(isPresented: $viewModel.showingError) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.errorMessage ?? ""),
                  dismissButton: .default(Text("OK")))
        }
    }

    private var themeColor: Color {
        switch themeManager.theme {
        case .dark: return .white
        case .pink: return .pink
        default: return .black
        }
    }

    private var themeBackground: Color {
        themeManager.theme == .pink ? Color.pink.opacity(0.3) : Color.clear
    }
}
