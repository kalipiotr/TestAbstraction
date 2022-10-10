import Foundation

protocol WeatherInfoProviderProtocol {
    func getUrl(for city: String) -> String
}

class WeatherInfoProvider: WeatherInfoProviderProtocol {
    func getUrl(for city: String) -> String {
        "https://www.meteo.pl/um/metco/mgram_pict.php?ntype=0u&fdate=2022101018&row=406&col=250&lang=pl"
    }
}
