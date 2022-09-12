import Swinject

public extension Injector {
    func register<T>(for type: T.Type,
                     factory: @escaping (Resolvable) -> T?) {
        register(for: type,
                 serviceName: nil,
                 scope: defaultScope,
                 factory: factory)
    }

    func register<T>(for type: T.Type,
                     scope: RegistrableScope,
                     factory: @escaping (Resolvable) -> T?) {
        register(for: type,
                 serviceName: nil,
                 scope: scope,
                 factory: factory)
    }

    func register<T, P>(for type: T.Type,
                        parent parentType: P.Type,
                        factory: @escaping (Resolvable) -> T?) {
        let name = String(describing: parentType)
        register(for: type,
                 serviceName: name,
                 scope: defaultScope,
                 factory: factory)
    }

    func register<T, P>(for type: T.Type,
                        parent parentType: P.Type,
                        scope: RegistrableScope,
                        factory: @escaping (Resolvable) -> T?) {
        let name = String(describing: parentType)
        register(for: type,
                 serviceName: name,
                 scope: scope,
                 factory: factory)
    }

    func register<T>(for type: T.Type,
                     name: String?,
                     factory: @escaping (Resolvable) -> T?) {
        register(for: type,
                 serviceName: name,
                 scope: defaultScope,
                 factory: factory)
    }

    func register<T>(for type: T.Type,
                     name: String?,
                     scope: RegistrableScope,
                     factory: @escaping (Resolvable) -> T?) {
        register(for: type,
                 serviceName: name,
                 scope: scope,
                 factory: factory)
    }

    func register<T>(for type: T.Type,
                     key: AssemblyKey?,
                     factory: @escaping (Resolvable) -> T?) {
        register(for: type,
                 serviceName: key?.rawValue,
                 scope: defaultScope,
                 factory: factory)
    }

    func register<T>(for type: T.Type,
                     key: AssemblyKey?,
                     scope: RegistrableScope,
                     factory: @escaping (Resolvable) -> T?) {
        register(for: type,
                 serviceName: key?.rawValue,
                 scope: scope,
                 factory: factory)
    }
    
    private func register<T>(for type: T.Type,
                             serviceName name: String?,
                             scope: RegistrableScope,
                             factory: @escaping (Resolvable) -> T?) {
        container.register(type, name: name) { resolver in
            guard let resolver = resolver as? Container else {
                fatalError("[Injector] Incorrect DI configuration")
            }
            guard let service = factory(resolver) else {
                fatalError("[Injector] Factory should not create empty service")
            }
            return service
        }
        .inObjectScope(getScope(from: scope))
    }
}
