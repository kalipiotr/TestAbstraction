# TestAbstraction

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.6-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-ios+mac-brightgreen.svg?style=flat" alt="iOS" />
</p>

Welcome to TestAbstraction, an abstraction layer for Unit tests built specifically for project, which uses [SwiftInject](https://github.com/Swinject/Swinject). It enables limit boilerplate code in Unit tests and make assembly object for testing purpose easly. 

## Unit tests with autoreleasing resources

### Presenter tests - WeatherInfoPresenterTests
    
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
    }
