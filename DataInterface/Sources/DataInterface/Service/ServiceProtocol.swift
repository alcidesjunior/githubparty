import Foundation

public protocol NetworkManagerProtocol {
    func execute<T: Codable>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void)
}
