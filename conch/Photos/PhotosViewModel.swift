import SwiftUI

class PhotosViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
        fetchPhotos()
    }

    func fetchPhotos() {
        let urlString = "https://api.vk.com/method/photos.getAll?access_token=\(accessToken)&v=5.131"

        NetworkService.shared.fetchData(urlString) { (response: [Photo]?) in
            DispatchQueue.main.async {
                self.photos = response?.compactMap { $0.url != nil ? $0 : nil } ?? []
            }
        }
    }
}
