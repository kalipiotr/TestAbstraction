import Foundation

@testable import TestAbstraction

public protocol AssemblablePresenterTestCase: AssemblableTestCase {
    associatedtype SutView

    var view: SutView! { get set }

    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       view: @autoclosure () -> SutView)
    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       view: @autoclosure () -> SutView,
                       sut: @autoclosure () -> Sut)
}

public extension AssemblablePresenterTestCase {
    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       view: @autoclosure () -> SutView) {
        self.view = view()
        setUpTestCase(assembly: assembly())
    }

    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       view: @autoclosure () -> SutView,
                       sut: @autoclosure () -> Sut) {
        self.view = view()
        setUpTestCase(assembly: assembly(),
                      sut: sut())
    }
}
