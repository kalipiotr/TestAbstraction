public class ModuleFactoryAssembly: Assembly {
    public func assemble(injector: Injectable) {
        injector.register(for: AnyModuleFactory.self,
                          factory: AnyModuleFactory())
        
        injector.register(for: WeatherInfoModuleFactory.self,
                          factory: moduleFactory)
    }
    
    private func moduleFactory(resolver: Resolvable) -> AnyModuleFactory {
        resolver.resolve(for: AnyModuleFactory.self)
    }
}
