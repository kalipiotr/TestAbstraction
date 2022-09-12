import Foundation

@testable import TestAbstraction

public class TestsAssembly: Assembly {
    private var assemblies = AssemblyGroup([
        TestsSessionsAssembly()
    ])

    public func assemble(injector: Injectable) {
        assemblies.assemble(injector: injector)
    }
}
