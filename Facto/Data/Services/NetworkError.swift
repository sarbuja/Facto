import Foundation

enum NetworkError: Error, Equatable, LocalizedError {
    case invalidUrlRequest
    case requestError
    case invalidData(String)
    case statusError
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidUrlRequest:
            return "Invalid URL Request"
        case .requestError:
            return "Request Error"
        case .invalidData(let message):
            return "Invalid \(message)"
        case .statusError:
            return "Status Error"
        case .decodingError:
            return "Decoding Error"
        }
    }
}
