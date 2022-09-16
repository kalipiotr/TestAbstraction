import UIKit

protocol WindowBuilderProtocol {
    func build(with rootController: UIViewController) -> UIWindow
}

final class WindowBuilder: WindowBuilderProtocol {
    public func build(with rootController: UIViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootController
        
        rootController.view.backgroundColor = .blue

        return window
    }
}
