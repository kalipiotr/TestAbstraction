import Foundation
import WebKit

protocol WebViewShowable {
    var webView: WebView { get }
    
    func loadUrl(_ url: String)
}

extension WebViewShowable {
    func loadUrl(_ url: String) {
        webView.load(url)
    }
}

class WebView: WKWebView {
    var onCommitNavigation: (() -> Void)?
    var onFinishNavigation: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(javaScriptEnabled: Bool = true) {
        let configuration = WKWebViewConfiguration(javaScriptEnabled: javaScriptEnabled)
        super.init(frame: .zero, configuration: configuration)
        navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        onCommitNavigation?()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        onFinishNavigation?()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onError?(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        onError?(error)
    }
}

extension WKWebViewConfiguration {
    convenience init(javaScriptEnabled: Bool) {
        self.init()
        defaultWebpagePreferences.allowsContentJavaScript = javaScriptEnabled
    }
}

extension WebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
