import Swinject

public enum RegistrableScope {
    case container
    case graph
    case transient
}

public protocol Assemblable {
    func assemble(_ assemblies: [Assembly])
}

public typealias Injectable = Registrable & Resolvable & ResolvableWithMapper & Assemblable

public class Injector: Injectable {
    public static var main: Injectable = Injector()

    public var containerScope: ObjectScopeProtocol
    public var graphScope: ObjectScopeProtocol
    public var transientScope: ObjectScopeProtocol
    public var container: Container
    public var defaultScope: RegistrableScope

    public init(defaultScope: RegistrableScope = .transient,
                container: Container = .init()) {
        self.containerScope = ObjectScope(storageFactory: PermanentStorage.init)
        self.graphScope = ObjectScope(storageFactory: GraphStorage.init)
        self.transientScope = ObjectScope(storageFactory: TransientStorage.init)
        self.container = container
        self.defaultScope = defaultScope
    }

    public func assemble(_ assemblies: [Assembly]) {
        for assembly in assemblies {
            assembly.assemble(injector: self)
        }
    }

    public func getScope(from scope: RegistrableScope) -> ObjectScopeProtocol {
        switch scope {
        case .container: return containerScope
        case .graph: return graphScope
        case .transient: return transientScope
        }
    }
}
