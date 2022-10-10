import UIKit

struct Layout {
    let element: UIView
    
    init(_ element: UIView) {
        self.element = element
        self.element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    func pinEdgesToSuperview() -> [NSLayoutConstraint] {
        let verticalConstraints = pinVerticalEdgesToSuperView()
        let horizontalConstraints = pinHorizontalEdgesToSuperView()
        return verticalConstraints + horizontalConstraints
    }
    
    @discardableResult
    func pinHorizontalEdgesToSuperView(padding: CGFloat = 0) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(element.leadingAnchor.constraint(equalTo: safeSuperview().leadingAnchor,
                                                            constant: padding))
        constraints.append(element.trailingAnchor.constraint(equalTo: safeSuperview().trailingAnchor,
                                                             constant: -padding))
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func pinVerticalEdgesToSuperView(padding: CGFloat = 0, useSafeArea: Bool = false) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let superView = safeSuperview()
        let topAnchor = useSafeArea ? superView.safeAreaLayoutGuide.topAnchor : superView.topAnchor
        let bottomAnchor = useSafeArea ? superView.safeAreaLayoutGuide.bottomAnchor : superView.bottomAnchor
        constraints.append(element.topAnchor.constraint(equalTo: topAnchor,
                                                        constant: padding))
        constraints.append(element.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                           constant: -padding))
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    private func safeSuperview() -> UIView {
        guard let view = element.superview else {
            fatalError("You need to have a superview before you can add contraints")
        }
        return view
    }
}

extension UIView {
    var layout: Layout {
        return Layout(self)
    }
}
