import UIKit

@testable import TestAbstraction

class WeatherInfoVCMock: UIViewController, WeatherInfoView, MethodCallCallable {
    var webView: WebView = WebView()

    var methodCallStorage: MethodCallStorage = MethodCallStorage()

    func setTitle(_ title: String?) {
        call(#function, params: title)
    }

    func loadUrl(_ url: String) {
        call(#function, params: url)
    }

    func showSimpleMessageAlert(message: String, title: String?) {
        call(#function, params: message, title)
    }
}
