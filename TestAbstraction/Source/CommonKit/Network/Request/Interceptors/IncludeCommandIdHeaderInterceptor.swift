import Foundation

class IncludeCommandIdHeaderInterceptor: RequestInterceptor {
    private let commandIdValue: String

    init(value: @escaping @autoclosure () -> String = HTTPHeader.Value.requestId) {
        self.commandIdValue = value()
    }

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        guard urlRequest.allHTTPHeaderFields?[HTTPHeader.Key.commandId] == .none else {
            return urlRequest
        }

        var request = urlRequest
        var headers = request.allHTTPHeaderFields ?? [:]
        headers[HTTPHeader.Key.commandId] = commandIdValue
        request.allHTTPHeaderFields = headers
        return request
    }
}
