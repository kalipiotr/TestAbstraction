class AppAssembly: Assembly {
    private var assemblies = AssemblyGroup([
        // use alphabetical order
        BuildersAssembly(),
        ConfiguratorsAssembly(),
        ModuleFactoryAssembly(),
        OtherAssembly(),
        ProvidersAssembly()
    ])

    public func assemble(injector: Injectable) {
        assemblies.assemble(injector: injector)
    }
}
