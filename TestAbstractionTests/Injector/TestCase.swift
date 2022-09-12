import Foundation
import XCTest

@testable import TestAbstraction

public protocol TestCase: AnyObject, TearDownTestCase, InjectableTestCase {
    associatedtype Sut

    var sut: Sut! { get set }

    func setUpTestCase(sut: @autoclosure () -> Sut)
    func tearDownTestCase()
    func registerAutoTearDown()
}

public extension TestCase {
    func setUpTestCase() {
        self.sut = nil
        registerAutoTearDown()
    }

    func setUpTestCase(sut: @autoclosure () -> Sut) {
        self.sut = sut()
        registerAutoTearDown()
    }

    func tearDownTestCase() {
        tearDownProperties(for: self)
        injector.tearDown()
    }
}

public extension TestCase where Self: XCTestCase {
    func registerAutoTearDown() {
        addTeardownBlock { [weak self] in
            self?.tearDownTestCase()
        }
    }
}
