import SwiftUI

struct PhotosView: View {
    @StateObject private var viewModel: PhotosViewModel

    init(accessToken: String) {
        _viewModel = StateObject(wrappedValue: PhotosViewModel(accessToken: accessToken))
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(viewModel.photos) { photo in
                    if let urlString = photo.url, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .navigationTitle("Фото")
    }
}
