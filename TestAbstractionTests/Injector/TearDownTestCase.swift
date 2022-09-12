import Foundation

@testable import TestAbstraction

public protocol TearDownTestCase {
    func tearDownTestCase()
}

public extension TearDownTestCase {
    func tearDownTestCase() {
        tearDownProperties(for: self)
    }

    func tearDownProperties(for object: Any) {
        tearDownProperties(object: object)
        Mirror(reflecting: object).children
            .forEach { tearDownProperties(object: $0.value) }
    }

    private func tearDownProperties(object: Any) {
        let value = object as? TearDownPropertyProtocol
        value?.tearDown()
    }
}

public protocol TearDownPropertyProtocol {
    func tearDown()
}

@propertyWrapper
public class TearDownProperty<T>: TearDownPropertyProtocol {
    private var value: T!

    public var wrappedValue: T! {
        get { value }
        set { value = newValue }
    }

    public init(_ value: T? = nil) {
        self.value = value
    }

    public func tearDown() {
        value = nil
    }
}
