class AppAssembly: Assembly {
    private var assemblies = AssemblyGroup([
        // use alphabetical order
        BuildersAssembly(),
        ConfiguratorsAssembly(),
        ProvidersAssembly()
    ])

    public func assemble(injector: Injectable) {
        assemblies.assemble(injector: injector)
    }
}
