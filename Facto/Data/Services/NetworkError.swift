import Foundation

enum NetworkError: Error, Equatable {
    case invalidUrlRequest
    case requestError
    case invalidData(String)
    case statusError
    case decodingError
}
