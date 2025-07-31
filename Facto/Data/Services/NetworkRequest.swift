import Foundation

protocol NetworkRequest {
    var base: String { get }
    var path: String { get }
    var query: String? { get }
    func getUrlRequest() throws -> URLRequest
}

extension NetworkRequest {

    var base: String { "https://api.api-ninjas.com/" }

    var query: String? { nil }
}

struct FactRequest: NetworkRequest {

    var path: String {
        return "v1/facts"
    }

    func getUrlRequest() throws -> URLRequest {
        var queryString = ""
        if let query = query {
            queryString = "?" + query
        }
        guard let url = URL(string: base + path + queryString) else {
            throw NetworkError.invalidUrlRequest
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("qAwup7UkzNxppWWJ3OQOMg==8ASq8ybrhqP7AS1i", forHTTPHeaderField: "X-Api-Key")
        return urlRequest
    }
}
