import Foundation

@testable import TestAbstraction

class WeatherInfoProviderMock: WeatherInfoProviderProtocol {
    func getUrl(for city: String) -> String {
        "https://www.google.com"
    }
}
