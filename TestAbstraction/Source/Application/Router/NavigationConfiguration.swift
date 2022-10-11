struct NavigationConfiguration: OptionSet, Hashable {
    static let navigationBar = NavigationConfiguration(rawValue: 1 << 0)
    static let backButton    = NavigationConfiguration(rawValue: 1 << 1)
    static let rightItem     = NavigationConfiguration(rawValue: 1 << 2)
    
    static let standardRoot: NavigationConfiguration = [.navigationBar]
    static let details: NavigationConfiguration = [.navigationBar, .backButton]
    static let none: NavigationConfiguration = []
    
    public let rawValue: Int
}
