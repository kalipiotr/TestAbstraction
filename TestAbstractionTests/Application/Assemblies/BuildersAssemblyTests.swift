import XCTest

@testable import TestAbstraction

class BuildersAssemblyTests: XCTestCase, AssemblyTests {
    let assembly: Assembly = BuildersAssembly()
    let testCases: [AssemblyTestable] = [
        AssemblyTest(type: WindowBuilderProtocol.self)
    ]

    func testResolvingBuilders() {
        testAssembly()
    }
}
