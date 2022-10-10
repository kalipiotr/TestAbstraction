@testable import TestAbstraction

final class WeatherInfoPresenterTestsAssembly: Assembly {
    var weatherDataProvider = WeatherInfoProviderMock()

    func assemble(injector: Injectable) {
        injector.register(for: WeatherInfoProviderProtocol.self,
                          factory: self.weatherDataProvider)
    }
}
