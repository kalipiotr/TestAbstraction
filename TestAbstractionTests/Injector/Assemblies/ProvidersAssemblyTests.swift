import XCTest

@testable import TestAbstraction

class ProvidersAssemblyTests: XCTestCase, AssemblyTests {
    let assembly: Assembly = ProvidersAssembly()
    let testCases: [AssemblyTestable] = [
        AssemblyTest(type: WeatherInfoProviderProtocol.self)
    ]

    func testResolvingOverseers() {
        testAssembly()
    }
}
