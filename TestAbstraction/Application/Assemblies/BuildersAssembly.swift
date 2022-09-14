public class BuildersAssembly: Assembly {
    public func assemble(injector: Injectable) {
        injector.register(for: WindowBuilderProtocol.self,
                          factory: WindowBuilder())
    }
}
