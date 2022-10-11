import Foundation
import UIKit

final class WeatherInfoCoordinator: Coordinator {
    private var router: Router
    private var standardRootNavigation: NavigationConfiguration = .standardRoot

    @Injected
    private var moduleFactory: WeatherInfoModuleFactory
    
    override init(router: Router) {
        self.router = router
        super.init(router: router)

        self.initialNavigationConfiguration = standardRootNavigation
    }
    
    // MARK: - Life cycle
    
    override func start() {
        super.start()
        presentInfo()
    }
    
    private func presentInfo() {
        let module = moduleFactory.makeInfoView()
        router.setRoot(module, configuration: standardRootNavigation)
    }
}
