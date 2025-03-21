import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photoUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoUrl = "photo_200"
    }
}
