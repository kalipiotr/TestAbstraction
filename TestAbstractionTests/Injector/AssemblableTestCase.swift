import Foundation

@testable import TestAbstraction

public protocol AssemblableTestCase: TestCase {
    associatedtype SutAssembly: TestAbstraction.Assembly
    associatedtype Sut

    var assembly: SutAssembly! { get set }
    var sut: Sut! { get set }

    func setUpTestCase(assembly: @autoclosure () -> SutAssembly)
    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       sut: @autoclosure () -> Sut)
    func tearDownTestCase()
    func registerAutoTearDown()
}

public extension AssemblableTestCase {
    func setUpTestCase(assembly: @autoclosure () -> SutAssembly) {
        self.assembly = assembly()
        injector.setUp(self.assembly)
        setUpTestCase()
    }

    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       sut: @autoclosure () -> Sut) {
        self.assembly = assembly()
        injector.setUp(self.assembly)
        setUpTestCase(sut: sut())
    }

    func tearDownTestCase() {
        let assembly: SutAssembly = self.assembly
        tearDownProperties(for: assembly)
        tearDownProperties(for: self)
        injector.tearDown()
    }
}
