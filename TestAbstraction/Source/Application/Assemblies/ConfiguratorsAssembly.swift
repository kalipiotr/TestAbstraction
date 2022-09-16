public enum ConfigurationAssemblyServerConfigurationKey: String, AssemblyKey {
    case isProduction = "is_production_server"
}

public class ConfiguratorsAssembly: Assembly {
    public func assemble(injector: Injectable) {
        injector.register(for: Bool.self,
                          key: ConfigurationAssemblyServerConfigurationKey.isProduction,
                          factory: ServerConfiguration.isProduction)
    }
}
