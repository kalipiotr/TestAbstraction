import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    @Injected(options: .lazy)
    var windowBuilder: WindowBuilderProtocol
    
    private lazy var rootController: UINavigationController = {
        UINavigationController(rootViewController: UIViewController())
    }()


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppConfigurator.configure([
            AssembliesConfigurator.self
        ])

        window = windowBuilder.build(with: rootController)
        window?.makeKeyAndVisible()
        return true
    }
}

