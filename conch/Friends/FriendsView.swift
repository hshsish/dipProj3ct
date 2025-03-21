import SwiftUI

struct FriendsView: View {
    @StateObject private var viewModel: FriendsViewModel

    init(accessToken: String) {
        _viewModel = StateObject(wrappedValue: FriendsViewModel(accessToken: accessToken))
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Обновление данных...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }

                List(viewModel.friends) { friend in
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.selectedFriend = friend
                        }
                    } label: {
                        HStack {
                            Text("\(friend.firstName) \(friend.lastName)")
                            Spacer()
                            Text(friend.online == 1 ? "🟢 Онлайн" : "⚫️ Офлайн")
                        }
                    }
                }
            }
            .navigationTitle("Друзья")
            .refreshable {
                viewModel.fetchFriends()
            }
            .fullScreenCover(item: $viewModel.selectedFriend) { friend in
                ProfileView(friendId: friend.id, accessToken: viewModel.accessToken)
                    .transition(.move(edge: .trailing))
            }
            .alert(isPresented: $viewModel.showingError) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK")) {
                        viewModel.errorMessage = nil
                    }
                )
            }
        }
    }
}
