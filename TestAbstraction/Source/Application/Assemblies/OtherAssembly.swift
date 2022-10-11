import Foundation
import UIKit

public class OtherAssembly: Assembly {
    public func assemble(injector: Injectable) {
        injector.register(for: CoordinatorFactory.self,
                          factory: AnyCoordinatorFactory())
    }
}
