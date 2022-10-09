import UIKit

protocol Coordinate {
    func start()
}

struct CoordinatorBox<T> {
    let router: Router
    let coordinator: T
}

class Coordinator: NSObject, Coordinate {
    private var router: Router

    weak var parentCoordinator: Coordinator?

    var isRootCoordinator: Bool = false
    var childCoordinators: [Coordinator] = []
    var completionNavigationConfiguration: NavigationConfiguration = []
    var initialNavigationConfiguration: NavigationConfiguration = .none
    
    init(router: Router) {
        self.router = router
    }

    /**
     Start method check whether all inner properties of Coordinator are set correctly.
     It should be invoke for each child class, which overrides this method, in the same as viewDidLoad.
     */
    public func start() {
        let isAssignedRequiredParentCoordinator = !isRootCoordinator && parentCoordinator != nil
        let isAssignedParentCoordinatorIfNeeded = isRootCoordinator || isAssignedRequiredParentCoordinator
        
        guard isAssignedParentCoordinatorIfNeeded else {
            fatalError("Please call addDependency before start method")
        }
    }
    
    public func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    public func removeDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        childCoordinators
            .enumerated()
            .filter { $0.element === coordinator }
            .forEach { childCoordinators.remove(at: $0.offset) }
    }

    public func removeAllDependencies(withRootConfiguration configuration: NavigationConfiguration = .bottomBar) {
        for coordinator in childCoordinators {
            removeDependency(coordinator)
        }
        childCoordinators.removeAll()
        router.popToRoot(configuration: configuration)
    }

    public func resetNavigationConfiguration() {
        router.resetNavigationConfiguration(to: initialNavigationConfiguration)
    }
}
