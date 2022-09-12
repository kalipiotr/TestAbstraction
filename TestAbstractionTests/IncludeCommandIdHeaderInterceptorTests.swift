import XCTest

@testable import TestAbstraction

final class IncludeCommandIdHeaderInterceptorTests: XCTestCase, AssemblableTestCase {
    @TearDownProperty var assembly: IncludeCommandIdHeaderInterceptorTestsAssembly!
    @TearDownProperty var sut: IncludeCommandIdHeaderInterceptor!

    override func setUp() {
        super.setUp()

        setUpTestCase(assembly: IncludeCommandIdHeaderInterceptorTestsAssembly(),
                      sut: IncludeCommandIdHeaderInterceptor(value: self.assembly.commandId))
    }

    func testInterceptSuccess() throws {
        let result = try sut.intercept(urlRequest: assembly.request)
        XCTAssertEqual(result.allHTTPHeaderFields?[HTTPHeader.Key.commandId], assembly.commandId)
    }

    func testInterceptSkip() throws {
        var request = assembly.request
        request.allHTTPHeaderFields = [HTTPHeader.Key.commandId: assembly.requestCommandId]

        let result = try sut.intercept(urlRequest: request)
        XCTAssertEqual(result.allHTTPHeaderFields?[HTTPHeader.Key.commandId], assembly.requestCommandId)
    }
}
