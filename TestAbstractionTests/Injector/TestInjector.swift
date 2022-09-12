import Foundation
import Swinject

@testable import TestAbstraction

public class TestsInjector: Injector {
    public let baseInjector: Injector = Injector()
    public var testContainerScope: ObjectScopeProtocol
    public var testGraphScope: ObjectScopeProtocol
    public var testTransientScope: ObjectScopeProtocol

    init(defaultScope: RegistrableScope = .graph) {
        self.testContainerScope = ObjectScope(storageFactory: PermanentStorage.init)
        self.testGraphScope = ObjectScope(storageFactory: GraphStorage.init)
        self.testTransientScope = ObjectScope(storageFactory: TransientStorage.init)
        super.init(defaultScope: defaultScope,
                   container: Container(parent: baseInjector.container))
        self.baseInjector.assemble([
            AppAssembly(),
            TestsAssembly()
        ])
    }

    public func setUp(_ assembly: TestAbstraction.Assembly) {
        assemble([assembly])
    }

    public func setUp(_ assemblies: [TestAbstraction.Assembly]) {
        assemble(assemblies)
    }

    public func tearDown() {
        container.removeAll()
        container = Container(parent: baseInjector.container)
    }

    override public func getScope(from scope: RegistrableScope) -> ObjectScopeProtocol {
        switch scope {
        case .container: return testContainerScope
        case .graph: return testGraphScope
        case .transient: return testTransientScope
        }
    }
}
