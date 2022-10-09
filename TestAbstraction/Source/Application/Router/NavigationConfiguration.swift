struct NavigationConfiguration: OptionSet, Hashable {
    static let navigationBar = NavigationConfiguration(rawValue: 1 << 0)
    static let bottomBar     = NavigationConfiguration(rawValue: 1 << 1)
    static let backButton    = NavigationConfiguration(rawValue: 1 << 2)
    static let rightItem     = NavigationConfiguration(rawValue: 1 << 3)
    
    static let standard: NavigationConfiguration = [.navigationBar, .bottomBar, .backButton]
    static let standardRoot: NavigationConfiguration = [.navigationBar, .bottomBar]
    static let details: NavigationConfiguration = [.navigationBar, .backButton]
    static let none: NavigationConfiguration = []
    
    public let rawValue: Int
}
