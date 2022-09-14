import XCTest

@testable import TestAbstraction

// MARK: AssemblyTestable

protocol AssemblyTestable {
    var description: String { get }

    func resolve(in injector: Injectable) -> Any?
}

struct AssemblyTest<T>: AssemblyTestable {
    let type: T.Type
    let name: String?

    var description: String {
        "\(type)"
    }

    init(type: T.Type,
         name: String? = nil) {
        self.type = type
        self.name = name
    }

    init<P>(type: T.Type,
            parent parentType: P.Type) {
        self.type = type
        self.name = String(describing: parentType)
    }

    init(type: T.Type,
         key: AssemblyKey) {
        self.type = type
        self.name = key.rawValue
    }

    func resolve(in injector: Injectable) -> Any? {
        injector.resolve(for: type, name: name)
    }
}

// MARK: AssemblyTests

typealias AssemblyAssert = (@autoclosure () throws -> Any?, @autoclosure () -> String, StaticString, UInt) -> Void

protocol AssemblyTests {
    var assembly: Assembly { get }
    var testCases: [AssemblyTestable] { get }
}

extension AssemblyTests {
    func testAssembly(file: StaticString = #file,
                      line: UInt = #line) {
        let injector = Injector()
        let assembly = self.assembly
        let testCases = self.testCases
        
        assert(injector: injector,
               testCases: testCases,
               assert: XCTAssertNil,
               file: file,
               line: line)
        
        injector.assemble([assembly])
        
        assert(injector: injector,
               testCases: testCases,
               assert: XCTAssertNotNil,
               file: file,
               line: line)
    }

    func assert(injector: Injectable,
                testCases: [AssemblyTestable],
                assert: AssemblyAssert,
                file: StaticString = #file,
                line: UInt = #line) {
        for testCase in testCases {
            let result: Any? = testCase.resolve(in: injector)
            assert(result, "Service: \(testCase.description) incorrect registration", file, line)
        }
    }
}
