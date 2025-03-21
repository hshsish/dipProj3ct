
import Foundation

class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(mockData, mockResponse, mockError)
        return URLSessionDataTask()
    }
}
