import APIKit
import Foundation

@testable import TestAbstraction

// swiftlint:disable session_usage

public class TestsSessionsAssembly: Assembly {
    public func assemble(injector: Injectable) {
        injector.register(for: Session.self,
                          factory: Session.shared)
    }
}
