struct Friend: Identifiable, Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
    }
}
