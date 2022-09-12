import Foundation

@testable import TestAbstraction

public protocol InjectableTestCase {
    var injector: TestsInjector! { get }
}

public extension InjectableTestCase {
    var injector: TestsInjector! {
        if !(Injector.main is TestsInjector) {
            Injector.main = TestsInjector()
        }
        return Injector.main as? TestsInjector
    }
}
