class AppAssembly: Assembly {
    private var assemblies = AssemblyGroup([
        // use alphabetical order
        BuildersAssembly()
    ])

    public func assemble(injector: Injectable) {
        assemblies.assemble(injector: injector)
    }
}
