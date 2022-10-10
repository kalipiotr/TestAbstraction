import XCTest

protocol XCTestExpecatationProvidable: AnyObject {
    func expectation(description: String) -> XCTestExpectation
}

extension XCTestCase: XCTestExpecatationProvidable {
    func expectation(description: String,
                     isInverted: Bool = false,
                     fulfillmentCount: Int = 1) -> XCTestExpectation {
        let testExpectation = expectation(description: description)
        testExpectation.isInverted = isInverted
        testExpectation.expectedFulfillmentCount = fulfillmentCount
        return testExpectation
    }
    
    func wait(for callables: [MethodCallCallable],
              timeout: XCTestCase.Timeout = .standard,
              file: StaticString = #file,
              line: UInt = #line) {
        for callable in callables {
            wait(for: callable, timeout: timeout, file: file, line: line)
        }
    }
    
    func wait(for callable: MethodCallCallable,
              timeout: XCTestCase.Timeout = .standard,
              file: StaticString = #file,
              line: UInt = #line) {
        let expectations = callable.methodCallStorage.expectations.compactMap { $0.expectation }
        
        let waiter = XCTWaiter()
        let result = waiter.wait(for: expectations, timeout: timeout.seconds, enforceOrder: true)
        if result != .completed {
            failWaiting(for: callable, result: result, file: file, line: line)
        }
    }
    
    private func failWaiting(for callable: MethodCallCallable,
                             result: XCTWaiter.Result,
                             file: StaticString = #file,
                             line: UInt = #line) {
        let expectations = callable.methodCallStorage.expectations.filter { !$0.isFulfilled }
        let methods = callable.methodCallStorage.methods.filter { !$0.isFulfilled }
        var message = failWaitingTitle(for: result)
        if !expectations.isEmpty {
            message += " Expected: "
            message += " [ " + expectations.map(\.description).joined(separator: " ") + " ]"
        }
        if !methods.isEmpty {
            message += " Called: "
            message += " [ " + methods.map(\.description).joined(separator: " ") + " ]"
        }
        XCTFail(message, file: file, line: line)
    }
    
    private func failWaitingTitle(for result: XCTWaiter.Result) -> String {
        switch result {
        case .completed:
            return "Success"
        case .timedOut:
            return "Timed out"
        case .incorrectOrder:
            return "Incorrect order"
        case .invertedFulfillment:
            return "Invertedfulfillment"
        case .interrupted:
            return "Interrupted"
        @unknown default:
            return "Unknown"
        }
    }
}
