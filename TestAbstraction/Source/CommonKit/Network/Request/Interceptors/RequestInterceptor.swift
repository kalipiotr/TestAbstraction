import Foundation

protocol RequestInterceptor {
    func intercept(urlRequest: URLRequest) throws -> URLRequest
}
