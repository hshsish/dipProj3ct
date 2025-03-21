import SwiftUI

struct ErrorResponse: Decodable {
    let error: ErrorDetails
}

struct ErrorDetails: Decodable {
    let errorCode: Int
    let errorMsg: String
}
