
import XCTest
import WebKit
import conch

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        expectation.fulfill()
    }
}
