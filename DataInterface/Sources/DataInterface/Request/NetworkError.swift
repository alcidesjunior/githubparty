public enum NetworkError: Error, Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData),
             (.invalidResponse, .invalidResponse),
             (.invalidURL, .invalidURL):
            return true
        case let (.genericError(lhsError), .genericError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.failedToDecode(lhsError), .failedToDecode(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.failedToEncode(lhsError), .failedToEncode(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
    case noData
    case invalidResponse
    case failedToDecode(Error)
    case failedToEncode(Error)
    case genericError(Error)
    case invalidURL
}
