import Foundation

enum ServerConfiguration {
    static var apiKey: String {
        ""
    }
    
    static var serverUrl: String {
        ""
    }
    
    static var isProduction: Bool {
        false
    }
    
    static var isNotProduction: Bool {
        !isProduction
    }
}
