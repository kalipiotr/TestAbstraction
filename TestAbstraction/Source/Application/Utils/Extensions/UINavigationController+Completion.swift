import UIKit

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}
