import UIKit

class WeatherInfoVC: UIViewController, WeatherInfoView {

    var presenter: WeatherInfoPresenter!

    let webView: WebView = WebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }

    public func setTitle(_ title: String?) {
        self.title = title
    }
    
    private func setupViews() {
        setupWebView()
    }
    
    private func setupWebView() {
        view.addSubview(webView)

        webView.layout.pinEdgesToSuperview()

//        webView.onError = { [weak self] _ in
//            guard let self = self else { return }
//
//            // TODO: handle error
//        }
    }
}
