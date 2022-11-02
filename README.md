# TestAbstraction

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.6-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-ios+mac-brightgreen.svg?style=flat" alt="iOS" />
</p>

Welcome to **TestAbstraction**, an abstraction layer for Unit Tests (XCTests) built specifically for project, which uses library [SwiftInject](https://github.com/Swinject/Swinject). It enables limit boilerplate code and make easy assembly object for testing purpose. 

## Basics

A class which inherit from [XCTestCase](https://developer.apple.com/documentation/xctest/xctestcase) is not able to deallocate objects created in [setUp](https://developer.apple.com/documentation/xctest/xctest/1500341-setup) method and stored in class variables in case of failing tests. The solution of  this problem is deallocate all variables in [tearDown](https://developer.apple.com/documentation/xctest/xctest/1500463-teardown) method. Doing it manually is bothersome. **TestAbstraction** register [a block of teardown code](https://developer.apple.com/documentation/xctest/xctestcase/3815521-addteardownblock/) in [setUpTestCase](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/Injector/TestCase.swift) method which allows to deallocate all variables anotted by [TearDownProperty](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/Injector/TearDownTestCase.swift) property wrapper.

The abstraction layer starts from a protocol **[TestCase](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/Injector/TestCase.swift)** which define generic type [Sut](https://en.wikipedia.org/wiki/System_under_test) and main method **setUpTestCase(sut:)** for initliation tests. It has to be invoked before the tests.

```swift
public protocol TestCase: AnyObject, TearDownTestCase, InjectableTestCase {
    associatedtype Sut

    var sut: Sut! { get set }

    func setUpTestCase(sut: @autoclosure () -> Sut)
    func tearDownTestCase()
    func registerAutoTearDown()
}
```

Next there is protocol **[AssemblableTestCase](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/Injector/AssemblableTestCase.swift)** which extends TestCase protocol and give possible to autoreleasing assembly and sut objects.

```swift
public extension AssemblableTestCase {
    func setUpTestCase(assembly: @autoclosure () -> SutAssembly,
                       sut: @autoclosure () -> Sut) {
        self.assembly = assembly()
        injector.setUp(self.assembly)
        setUpTestCase(sut: sut())
    }
```

## Examples of usage

### Presenter tests - WeatherInfoPresenterTests

Let's assume that we are building applications for displaying the weather forecast in the [Model–view–presenter (MVP)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) architectural pattern. There is [model](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstraction/Source/Flows/WeatherFlow/WeatherInfoProvider.swift), [view](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstraction/Source/Flows/WeatherFlow/WeatherInfoVC.swift), [presenter](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstraction/Source/Flows/WeatherFlow/WeatherInfoPresenter.swift) class. Presenter contains all logic. We would like to write tests for it. 


First step is to create new class [WeatherInfoPresenterTests](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/WeatherFlow/WeatherInfoPresenterTests.swift) which inherit from XCTestCase and conforms to protocol [AssemblablePresenterTestCase](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/Injector/AssemblablePresenterTestCase.swift). 

Next we define our [assembly object](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/IncludeCommandIdHeaderInterceptorTests%2BAssembly.swift), which will provide mocked data for presenter. It is stored in property named `assembly` and annotated as @TearDownProperty. TestAbstraction will automatically releasing object assigned to this property as test completion/failing. The view layer is defined as mocked - [WeatherInfoVCMock](https://github.com/kalipiotr/TestAbstraction/blob/main/TestAbstractionTests/WeatherFlow/Mocks/WeatherInfoVCMock.swift) and stored in `view` property. Test object - WeatherInfoPresenter is assigned to `sut` property. The most important step is to invoke from `setUp` method `setUpTestCase` with params: `assembly`, `view`, `sut`. Now `TestAbstraction` is ready to use. 

First test `testOnViewWillAppear` checks whether methods `setTitle` and `loadUrl` from view has been called by presenter with correct parameters. Line `sut.onViewWillAppear()` launch our presenter. We verify the result of presenter behaviour in wait method.   

```swift
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
```