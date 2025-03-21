import SwiftUI

class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func fetchData<T: Decodable>(_ urlString: String, completion: @escaping ([T]?) -> Void) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { completion(nil) }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            do {
                let decoder = JSONDecoder()

                if let decodedData = try? decoder.decode(ResponseWrapper<ResponseContainer<[T]>>.self, from: data) {
                    DispatchQueue.main.async { completion(decodedData.response.items) }
                } else if let decodedArray = try? decoder.decode(ResponseWrapper<[T]>.self, from: data) {
                    DispatchQueue.main.async { completion(decodedArray.response) }
                } else {
                    throw DecodingError.dataCorrupted(.init(codingPath: [],
                                                            debugDescription: "Не удалось разобрать JSON"))
                }
            } catch {
                print("Ошибка декодирования: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }
}
