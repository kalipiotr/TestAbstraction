import Swinject

public protocol Resolvable {
    func resolve<T>(for type: T.Type) -> T!
    func resolve<T, P>(for type: T.Type,
                       parent parentType: P.Type) -> T!
    func resolve<T>(for type: T.Type,
                    name: String?) -> T!
    func resolve<T>(for type: T.Type,
                    key: AssemblyKey?) -> T!
}

public protocol ResolvableWithMapper {
    func resolve<T, M>(for type: T.Type,
                       map mappedType: M.Type) -> M!
    func resolve<T, M, P>(for type: T.Type,
                          map mappedType: M.Type,
                          parent parentType: P.Type) -> M!
    func resolve<T, M>(for type: T.Type,
                       map mappedType: M.Type,
                       name: String?) -> M!
    func resolve<T, M>(for type: T.Type,
                       map mappedType: M.Type,
                       key: AssemblyKey?) -> M!
}

extension Container: Resolvable {
    public func resolve<T>(for type: T.Type) -> T! {
        resolve(for: type,
                name: nil)
    }
    
    public func resolve<T, P>(for type: T.Type,
                              parent parentType: P.Type) -> T! {
        let name = String(describing: parentType)
        return resolve(for: type,
                       name: name)
    }
    
    public func resolve<T>(for type: T.Type,
                           name: String?) -> T! {
        resolve(type, name: name)
    }

    public func resolve<T>(for type: T.Type,
                           key: AssemblyKey?) -> T! {
        resolve(type, name: key?.rawValue)
    }
}

extension Container: ResolvableWithMapper {
    public func resolve<T, M>(for type: T.Type,
                              map mappedType: M.Type) -> M! {
        resolve(for: type,
                map: mappedType,
                name: nil)
    }

    public func resolve<T, M, P>(for type: T.Type,
                                 map mappedType: M.Type,
                                 parent parentType: P.Type) -> M! {
        let name = String(describing: parentType)
        return resolve(for: type,
                       map: mappedType,
                       name: name)
    }
    
    public func resolve<T, M>(for type: T.Type,
                              map mappedType: M.Type,
                              name: String?) -> M! {
        resolve(for: type,
                name: name) as? M
    }

    public func resolve<T, M>(for type: T.Type,
                              map mappedType: M.Type,
                              key: AssemblyKey?) -> M! {
        resolve(for: type,
                key: key) as? M
    }
}
