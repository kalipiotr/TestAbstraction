import Swinject

public extension Injector {
    func resolve<T>(for type: T.Type) -> T! {
        resolve(for: type,
                name: nil)
    }

    func resolve<T, P>(for type: T.Type,
                       parent parentType: P.Type) -> T! {
        let name = String(describing: parentType)
        return resolve(for: type,
                       name: name)
    }

    // resolves service with name or default service
    func resolve<T>(for type: T.Type,
                    name: String?) -> T! {
        let resolver = container.synchronize()
        if let namedService = resolver.resolve(type, name: name) {
            return namedService
        } else if let defaultService = resolver.resolve(type, name: nil) {
            return defaultService
        } else {
            return nil
        }
    }

    // resolves service with key
    func resolve<T>(for type: T.Type,
                    key: AssemblyKey?) -> T! {
        resolve(for: type,
                name: key?.rawValue)
    }
    
    func resolve<T, M>(for type: T.Type,
                       map mappedType: M.Type) -> M! {
        resolve(for: type,
                map: mappedType,
                name: nil)
    }

    func resolve<T, M, P>(for type: T.Type,
                          map mappedType: M.Type,
                          parent parentType: P.Type) -> M! {
        let name = String(describing: parentType)
        return resolve(for: type,
                       map: mappedType,
                       name: name)
    }

    func resolve<T, M>(for type: T.Type,
                       map mappedType: M.Type,
                       name: String?) -> M! {
        resolve(for: type,
                name: name) as? M
    }

    func resolve<T, M>(for type: T.Type,
                       map mappedType: M.Type,
                       key: AssemblyKey?) -> M! {
        resolve(for: type,
                key: key) as? M
    }
}
