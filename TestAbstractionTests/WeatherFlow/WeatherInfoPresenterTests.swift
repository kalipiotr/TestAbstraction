import XCTest

@testable import TestAbstraction

final class WeatherInfoPresenterTests: XCTestCase, AssemblablePresenterTestCase {
    @TearDownProperty var assembly: WeatherInfoPresenterTestsAssembly!
    @TearDownProperty var sut: WeatherInfoPresenter!
    @TearDownProperty var view: WeatherInfoVCMock!

    override func setUp() {
        super.setUp()
        setUpTestCase(assembly: WeatherInfoPresenterTestsAssembly(),
                      view: WeatherInfoVCMock(),
                      sut: WeatherInfoPresenter(view: view))
    }

    func testOnViewWillAppear() {
        let url = assembly.weatherDataProvider.getUrl(for: "Warsaw")
        view.expect("setTitle", params: "Weather Info")
        view.expect("loadUrl", params: url)

        sut.onViewWillAppear()

        wait(for: [view])
    }
}
