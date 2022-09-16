import XCTest

@testable import TestAbstraction

class ConfiguratorsAssemblyTests: XCTestCase, AssemblyTests {
    let assembly: Assembly = ConfiguratorsAssembly()
    let testCases: [AssemblyTestable] = [
        AssemblyTest(type: Bool.self,
                     key: ConfigurationAssemblyServerConfigurationKey.isProduction)
    ]

    func testResolvingConfigurators() {
        testAssembly()
    }
}
