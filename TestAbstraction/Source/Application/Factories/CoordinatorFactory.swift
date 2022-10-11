import UIKit

protocol CoordinatorFactory {
    func makeWeatherInfo(router: Router) -> CoordinatorBox<Coordinator>
}
