import Foundation

final class WeatherInfoPresenter: ViewControllerPresenter {
    private weak var view: WeatherInfoView?

    @Injected
    private var dataProvider: WeatherInfoProviderProtocol

    init(view: WeatherInfoView) {
        self.view = view
    }

    public func onViewWillAppear() {
        setTitle("Weather Info")
        loadContent()
    }

    private func setTitle(_ title: String) {
        view?.setTitle(title)
    }

    private func loadContent() {

        let contentUrl = dataProvider.getUrl(for: "Warszawa")
        view?.loadUrl(contentUrl)
    }
}
