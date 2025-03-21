import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss

    init(friendId: Int, accessToken: String) {
        _viewModel = StateObject(wrappedValue: UserViewModel(accessToken: accessToken, userId: friendId))
    }

    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("\(user.firstName) \(user.lastName)")
                    .font(.title)
                    .padding()

                if let photoUrl = user.photoUrl, let url = URL(string: photoUrl) {
                    AsyncImage(url: url, content: { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFit()
                        case .failure:
                            Image(systemName: "photo")
                        case .empty:
                            ProgressView()
                        @unknown default:
                            ProgressView()
                        }
                    })
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                }
            } else {
                ProgressView()
            }

            Spacer()

            Button(action: {
                withAnimation {
                    dismiss()
                }
            }, label: {
                Label("Назад", systemImage: "arrow.left")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            })
        }
        .navigationTitle("Профиль")
        .alert(isPresented: $viewModel.showingError) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.errorMessage ?? ""),
                  dismissButton: .default(Text("OK")))
        }
    }
}
