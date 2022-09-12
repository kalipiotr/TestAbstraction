import UIKit

let kIsRunningTests = NSClassFromString("XCTestCase") != nil
let kAppDelegateClass = kIsRunningTests
    ? NSStringFromClass(TestsAppDelegate.self)
    : NSStringFromClass(AppDelegate.self)
UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  kAppDelegateClass)
