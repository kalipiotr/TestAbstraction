public class ProvidersAssembly: Assembly {
    public func assemble(injector: Injectable) {
        injector.register(for: WeatherInfoProviderProtocol.self,
                          factory: WeatherInfoProvider())
    }
}
