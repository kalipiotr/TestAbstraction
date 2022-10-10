import XCTest

extension XCTestCase {
    enum Timeout {
        case short
        case standard
        case long
        case custom(TimeInterval)

        var seconds: TimeInterval {
            switch self {
            case .short:
                return 0.2
            case .standard:
                return 5
            case .long:
                return 10
            case .custom(let value):
                return value
            }
        }
    }

    func wait(for expectations: [XCTestExpectation],
              timeout: Timeout = .standard,
              file: StaticString = #file,
              line: UInt = #line) {
        wait(for: expectations,
             timeout: timeout.seconds)
    }

    func waitForExpectation(description: String? = nil,
                            timeout: Timeout = .standard,
                            file: StaticString = #file,
                            line: UInt = #line,
                            action: (XCTestExpectation) -> Void) {
        let description = description ?? "The completion block should get called"
        let testExpectation = XCTestExpectation(description: description)
        action(testExpectation)
        wait(for: [testExpectation],
             timeout: timeout,
             file: file,
             line: line)
    }

    func waitForExpectations(timeout: Timeout = .standard) {
        waitForExpectations(timeout: timeout.seconds)
    }
}
