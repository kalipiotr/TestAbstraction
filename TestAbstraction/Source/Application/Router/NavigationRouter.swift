import UIKit

class NavigationRouter: NSObject, Router {
    public var onBackButtonPressed: (() -> Void)?
    
    private weak var rootController: UINavigationController?
    private var navigationConfiguration: NavigationConfiguration = .none
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        super.init()
    }
    
    func toPresent() -> UIViewController? {
        rootController
    }
    
    func setRoot(_ module: Presentable?,
                 configuration: NavigationConfiguration,
                 animated: Bool,
                 completion: (() -> Void)?) {
        guard let controller = module?.toPresent(),
              let rootController = rootController else { return }
        navigationConfiguration = configuration
        rootController.setViewControllers([controller], animated: animated)
        completion?()
    }
    
    func present(_ module: Presentable?,
                 animated: Bool,
                 completion: (() -> Void)?) {
        guard let controller = module?.toPresent(),
              let rootController = rootController else { return }

        controller.view.bounds = rootController.view.bounds
        controller.modalPresentationStyle = .overFullScreen

        rootController.present(controller, animated: animated) {
            completion?()
        }
    }
    
    func push(_ module: Presentable?,
              configuration: NavigationConfiguration,
              animated: Bool,
              completion: (() -> Void)?) {
        guard let controller = module?.toPresent(),
              let rootController = rootController else { return }
        guard !(controller is UINavigationController) else { return }

        navigationConfiguration = configuration

        rootController.pushViewController(controller, animated: animated) {
            completion?()
        }
    }
    
    func dismiss(animated: Bool,
                 completion: (() -> Void)?) {
        guard let rootController = rootController else { return }
        rootController.dismiss(animated: animated) {
            completion?()
        }
    }

    func popToRoot(configuration: NavigationConfiguration,
                   animated: Bool,
                   completion: (() -> Void)?) {
        guard let rootController = rootController else { return }
        navigationConfiguration = configuration
        rootController.popToRootViewController(animated: animated)
        completion?()
    }
}
