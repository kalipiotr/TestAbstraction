import UIKit

enum HTTPHeader {
    enum Key {
        static var commandId: String { "X-Command-Id" }
    }
    
    enum Value {
        static var requestId: String {
            UUID().uuidString
        }
    }
}
