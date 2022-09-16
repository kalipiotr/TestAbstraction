import Foundation

enum InjectedOptions {
    case standard
    case lazy
    case dynamic
}

@propertyWrapper
class Injected<Service> {
    private let options: InjectedOptions
    private let name: String?
    private var service: Service!
    private var injector: Injectable { Injector.main }
    
    var wrappedValue: Service {
        switch options {
        case .standard:
            return service
        case .lazy:
            if service == nil {
                service = injector.resolve(for: Service.self, name: name)
            }
            return service
        case .dynamic:
            return injector.resolve(for: Service.self, name: name)
        }
    }
    
    convenience init<T>(options: InjectedOptions = .standard,
                        parent: T.Type) {
        let parentName = String(describing: parent)
        self.init(options: options, name: parentName)
    }
    
    convenience init(options: InjectedOptions = .standard,
                     key: AssemblyKey) {
        self.init(options: options, name: key.rawValue)
    }
    
    convenience init(options: InjectedOptions = .standard) {
        self.init(options: options, name: nil)
    }
    
    private init(options: InjectedOptions,
                 name: String?) {
        self.options = options
        self.name = name
        if case .standard = options {
            self.service = injector.resolve(for: Service.self, name: name)
        }
    }
}

@propertyWrapper
class OptionalInjected<Service> {
    private let options: InjectedOptions
    private let name: String?
    private var service: Service?
    private var injector: Injectable { Injector.main }

    var wrappedValue: Service? {
        switch options {
        case .standard:
            return service
        case .lazy:
            if service == nil {
                service = injector.resolve(for: Service.self, name: name)
            }
            return service
        case .dynamic:
            return injector.resolve(for: Service.self, name: name)
        }
    }
    
    convenience init<T>(options: InjectedOptions = .standard,
                        parent: T.Type) {
        let parentName = String(describing: parent)
        self.init(options: options, name: parentName)
    }

    convenience init(options: InjectedOptions = .standard,
                     key: AssemblyKey) {
        self.init(options: options, name: key.rawValue)
    }

    convenience init(options: InjectedOptions = .standard) {
        self.init(options: options, name: nil)
    }

    private init(options: InjectedOptions,
                 name: String?) {
        self.options = options
        self.name = name
        if case .standard = options {
            self.service = injector.resolve(for: Service.self, name: name)
        }
    }
}
