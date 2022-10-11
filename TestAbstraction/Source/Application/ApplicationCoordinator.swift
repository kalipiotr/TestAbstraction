import Foundation
import UIKit

final class ApplicationCoordinator: Coordinator {
    @Injected
    private var coordinatorFactory: CoordinatorFactory
    
    private let router: Router
    
    override init(router: Router) {
        self.router = router
        
        super.init(router: router)
        
        self.isRootCoordinator = true
    }
    
    override func start() {
        super.start()
        runMainFlow()
    }
    
    public func runMainFlow() {
        let box = coordinatorFactory.makeWeatherInfo(router: router)
        let coordinator = box.coordinator
        
        addDependency(coordinator)
        coordinator.start()
    }
}
