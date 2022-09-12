import Swinject

public protocol RegistrableAnonymous {
    func register<T>(for type: T.Type,
                     factory: @escaping (Resolvable) -> T?)
    func register<T>(for type: T.Type,
                     scope: RegistrableScope,
                     factory: @escaping (Resolvable) -> T?)
}

public protocol RegistrableWithParent {
    func register<T, P>(for type: T.Type,
                        parent parentType: P.Type,
                        factory: @escaping (Resolvable) -> T?)
    func register<T, P>(for type: T.Type,
                        parent parentType: P.Type,
                        scope: RegistrableScope,
                        factory: @escaping (Resolvable) -> T?)
}

public protocol RegistrableWithName {
    func register<T>(for type: T.Type,
                     name: String?,
                     factory: @escaping (Resolvable) -> T?)
    func register<T>(for type: T.Type,
                     name: String?,
                     scope: RegistrableScope,
                     factory: @escaping (Resolvable) -> T?)
}

public protocol RegistrableWithKey {
    func register<T>(for type: T.Type,
                     key: AssemblyKey?,
                     factory: @escaping (Resolvable) -> T?)
    func register<T>(for type: T.Type,
                     key: AssemblyKey?,
                     scope: RegistrableScope,
                     factory: @escaping (Resolvable) -> T?)
}

public protocol Registrable: RegistrableAnonymous, RegistrableWithParent, RegistrableWithName, RegistrableWithKey { }

// MARK: Autoclosure
extension RegistrableAnonymous {
    func register<T>(for type: T.Type,
                     scope: RegistrableScope,
                     factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 scope: scope) { _ in
            factory()
        }
    }

    func register<T>(for type: T.Type,
                     factory: @autoclosure @escaping () -> T?) {
        register(for: type) { _ in
            factory()
        }
    }
}

extension RegistrableWithParent {
    func register<T, P>(for type: T.Type,
                        parent parentType: P.Type,
                        factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 parent: parentType) { _ in
            factory()
        }
    }

    func register<T, P>(for type: T.Type,
                        parent parentType: P.Type,
                        scope: RegistrableScope,
                        factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 parent: parentType,
                 scope: scope) { _ in
            factory()
        }
    }
}

extension RegistrableWithName {
    func register<T>(for type: T.Type,
                     name: String?,
                     factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 name: name) { _ in
            factory()
        }
    }

    func register<T>(for type: T.Type,
                     name: String?,
                     scope: RegistrableScope,
                     factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 name: name,
                 scope: scope) { _ in
            factory()
        }
    }
}

extension RegistrableWithKey {
    func register<T>(for type: T.Type,
                     key: AssemblyKey?,
                     factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 key: key) { _ in
            factory()
        }
    }

    func register<T>(for type: T.Type,
                     key: AssemblyKey?,
                     scope: RegistrableScope,
                     factory: @autoclosure @escaping () -> T?) {
        register(for: type,
                 key: key,
                 scope: scope) { _ in
            factory()
        }
    }
}
