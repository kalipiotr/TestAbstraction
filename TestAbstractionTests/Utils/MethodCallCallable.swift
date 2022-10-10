import XCTest

protocol MethodDescription {
    var selector: String { get }
    var params: [Any?] { get }
    var details: String? { get }
    var isFulfilled: Bool { get }
    var description: String { get }
}

extension MethodDescription {
    var description: String {
        [
            selector.components(separatedBy: "(").first ?? selector,
            details ?? params.description
        ].joined(separator: "-")
    }
}

class MethodExpectation: MethodDescription {
    let selector: String
    let params: [Any?]
    let details: String?
    let expectation: XCTestExpectation?
    var isFulfilled: Bool

    public init(selector: String,
                params: [Any?],
                details: String?,
                expectation: XCTestExpectation?) {
        self.selector = selector
        self.params = params
        self.details = details
        self.expectation = expectation
        self.isFulfilled = false
    }
}

class MethodCall: MethodDescription {
    let selector: String
    let params: [Any?]
    let details: String?
    var isFulfilled: Bool

    public init(selector: String,
                params: [Any?],
                details: String?) {
        self.selector = selector
        self.params = params
        self.details = details
        self.isFulfilled = false
    }
}

typealias MethodParams = [Any?]

extension MethodParams {
    var description: String {
        self.map { param -> String in
            if let value = param {
                return "\(value)"
            } else {
                return "nil"
            }
        }
        .joined(separator: "-")
    }
}

class MethodCallStorage {
    var methods: [MethodCall] = []
    var expectations: [MethodExpectation] = []
}

protocol MethodCallCallable: AnyObject {
    var methodCallStorage: MethodCallStorage { get }
}

extension MethodCallCallable {
    func expectation(for selector: String,
                     isInverted: Bool = false) -> XCTestExpectation {
        let expectionLastPartDescription = isInverted ? "do not method expectation" : "method expectation"
        let expectation = XCTestExpectation(description: "\(selector) \(expectionLastPartDescription)")
        expectation.isInverted = isInverted
        return expectation
    }
    
    func doNotExpect(_ selector: String) {
        let expectation = MethodExpectation(selector: selector,
                                            params: [],
                                            details: nil,
                                            expectation: self.expectation(for: selector,
                                                                          isInverted: true))
        methodCallStorage.expectations.append(expectation)
    }

    func expect(_ selector: String,
                details: String? = nil) {
        let expectation = MethodExpectation(selector: selector,
                                            params: [],
                                            details: details,
                                            expectation: self.expectation(for: selector))
        methodCallStorage.expectations.append(expectation)
    }

    func expect(_ selector: String,
                params: Any?...) {
        let expectation = MethodExpectation(selector: selector,
                                            params: params,
                                            details: nil,
                                            expectation: self.expectation(for: selector))
        methodCallStorage.expectations.append(expectation)
    }

    func call(_ selector: String,
              details: String? = nil) {
        let call = MethodCall(selector: selector,
                              params: [],
                              details: details)
        fulfillExpectation(for: call)
        methodCallStorage.methods.append(call)
    }

    func call(_ selector: String,
              params: Any?...) {
        let call = MethodCall(selector: selector,
                              params: params,
                              details: nil)
        fulfillExpectation(for: call)
        methodCallStorage.methods.append(call)
    }

    func resetExpectations() {
        methodCallStorage.expectations = []
        methodCallStorage.methods = []
    }

    private func expectation(for call: MethodCall) -> MethodExpectation? {
        let methodExpectation = methodCallStorage.expectations.first(where: { match(expectation: $0, call: call) })
        return methodExpectation
    }

    private func fulfillExpectation(for call: MethodCall) {
        guard let methodExpectation = self.expectation(for: call) else {
            return
        }
        methodExpectation.expectation?.fulfill()
        methodExpectation.isFulfilled = true
        call.isFulfilled = true
    }

    private func match(expectation: MethodExpectation,
                       call: MethodCall) -> Bool {
        guard !expectation.isFulfilled else { return false }
        if matchSelectors(expectation: expectation, call: call) { // match selectors
            return matchParameters(expectation: expectation, call: call)
        } else if matchMethodNames(expectation: expectation, call: call) { // match names
            return matchParameters(expectation: expectation, call: call)
        } else {
            return false
        }
    }

    private func matchSelectors(expectation: MethodExpectation,
                                call: MethodCall) -> Bool {
        expectation.selector == call.selector
    }

    private func matchMethodNames(expectation: MethodExpectation,
                                  call: MethodCall) -> Bool {
        let expectationMethodName = methodName(for: expectation.selector)
        let callMethodName = methodName(for: call.selector)
        return expectationMethodName == callMethodName
    }

    private func matchParameters(expectation: MethodExpectation,
                                 call: MethodCall) -> Bool {
        if expectation.details == nil && call.details == nil {
            return expectation.params.description == call.params.description
        } else {
            return expectation.details == call.details
        }
    }

    private func methodName(for selector: String) -> String {
        selector.components(separatedBy: "(").first ?? selector
    }
}
