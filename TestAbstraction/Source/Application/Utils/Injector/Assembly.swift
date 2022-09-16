import Foundation

public protocol Assembly {
    static var name: String { get }
    var name: String { get }

    func assemble(injector: Injectable)
}

public extension Assembly {
    static var name: String {
        String(describing: self)
    }

    var name: String {
        Self.name
    }
}

public struct AssemblyGroup: Assembly {
    public let assemblies: [Assembly]

    public init(_ assemblies: [Assembly]) {
        self.assemblies = assemblies
    }

    public func assemble(injector: Injectable) {
        for assembly in assemblies {
            assembly.assemble(injector: injector)
        }
    }
}

public protocol AssemblyKey {
    var rawValue: String { get }
}
