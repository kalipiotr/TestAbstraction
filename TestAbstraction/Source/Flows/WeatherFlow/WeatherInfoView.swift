import UIKit

protocol WeatherInfoView: BaseView, WebViewShowable {
    var webView: WebView { get }
    
    func setTitle(_ title: String?)
}
