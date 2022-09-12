import UIKit

class TestsAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var rootController: UINavigationController = {
        UINavigationController(rootViewController: UIViewController())
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppConfigurator.configure([
            AssembliesConfigurator.self,
        ])

        return true
    }
}
