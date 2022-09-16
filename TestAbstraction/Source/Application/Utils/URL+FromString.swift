import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            fatalError("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
