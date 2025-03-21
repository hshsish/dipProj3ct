import Foundation

struct Photo: Identifiable, Decodable {
    let id: Int
    let sizes: [PhotoSize]

    var url: String? { sizes.last?.url }
}

struct PhotoSize: Decodable {
    let url: String
}
