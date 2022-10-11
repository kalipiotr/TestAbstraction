extension AnyModuleFactory: WeatherInfoModuleFactory {
    public func makeInfoView() -> WeatherInfoView {
        let view = WeatherInfoVC()
        let presenter = WeatherInfoPresenter(view: view)
        
        view.presenter = presenter
        
        return view
    }
}
