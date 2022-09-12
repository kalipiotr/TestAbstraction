import Foundation

/// `IncludeCommandIdHeaderInterceptor` struct encapsulate functionality of adding
/// http header X-Command-Id with identify request in entur
/// If the query contains header, the header will not be regenerated
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
