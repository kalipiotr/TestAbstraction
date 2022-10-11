import UIKit

final class AnyCoordinatorFactory: CoordinatorFactory {
    
    func makeWeatherInfo(router: Router) -> CoordinatorBox<Coordinator> {
        let coordinator = WeatherInfoCoordinator(router: router)
        return CoordinatorBox(router: router,
                              coordinator: coordinator)
    }
    
}
