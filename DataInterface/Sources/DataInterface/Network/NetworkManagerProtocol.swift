import Foundation

public protocol NetworkManagerProtocol {
    func execute<T: Codable>(page: Int, request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void)
}
