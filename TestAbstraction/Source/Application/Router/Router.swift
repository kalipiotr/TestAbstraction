import UIKit

protocol Router: Presentable {
    var onBackButtonPressed: (() -> Void)? { get set }

    // present
    func present(_ module: Presentable?)
    func present(_ module: Presentable?,
                 animated: Bool)
    func present(_ module: Presentable?,
                 animated: Bool,
                 completion: (() -> Void)?)

    // push
    func push(_ module: Presentable?)
    func push(_ module: Presentable?,
              configuration: NavigationConfiguration)
    func push(_ module: Presentable?,
              animated: Bool)
    func push(_ module: Presentable?,
              configuration: NavigationConfiguration,
              animated: Bool)
    func push(_ module: Presentable?,
              configuration: NavigationConfiguration,
              animated: Bool,
              completion: (() -> Void)?)

    // set root
    func setRoot(_ module: Presentable?)
    func setRoot(_ module: Presentable?,
                 configuration: NavigationConfiguration)
    func setRoot(_ module: Presentable?,
                 configuration: NavigationConfiguration,
                 animated: Bool)
    func setRoot(_ module: Presentable?,
                 configuration: NavigationConfiguration,
                 animated: Bool,
                 completion: (() -> Void)?)

    // dismiss
    func dismiss()
    func dismiss(animated: Bool)
    func dismiss(animated: Bool,
                 completion: (() -> Void)?)

    // pop to root
    func popToRoot()
    func popToRoot(configuration: NavigationConfiguration)
    func popToRoot(configuration: NavigationConfiguration,
                   animated: Bool)
    func popToRoot(configuration: NavigationConfiguration,
                   animated: Bool,
                   completion: (() -> Void)?)
}

// MARK: Present
extension Router {
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?,
                 animated: Bool) {
        present(module, animated: animated, completion: nil)
    }
}

// MARK: Push
extension Router {
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    func push(_ module: Presentable?,
              configuration: NavigationConfiguration) {
        push(module, configuration: configuration, animated: true)
    }

    func push(_ module: Presentable?,
              animated: Bool) {
        push(module, configuration: .none, animated: animated)
    }

    func push(_ module: Presentable?,
              configuration: NavigationConfiguration,
              animated: Bool) {
        push(module, configuration: configuration, animated: animated, completion: nil)
    }
}

// MARK: Set root
extension Router {
    func setRoot(_ module: Presentable?) {
        setRoot(module, configuration: .none)
    }

    func setRoot(_ module: Presentable?,
                 configuration: NavigationConfiguration) {
        setRoot(module, configuration: configuration, animated: false)
    }

    func setRoot(_ module: Presentable?,
                 configuration: NavigationConfiguration,
                 animated: Bool) {
        setRoot(module, configuration: configuration, animated: animated, completion: nil)
    }
}

// MARK: Dismiss
extension Router {
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}

// MARK: Pop to root
extension Router {
    func popToRoot() {
        popToRoot(configuration: .none)
    }

    func popToRoot(configuration: NavigationConfiguration) {
        popToRoot(configuration: configuration, animated: true)
    }

    func popToRoot(configuration: NavigationConfiguration,
                   animated: Bool) {
        popToRoot(configuration: configuration, animated: animated, completion: nil)
    }
}
