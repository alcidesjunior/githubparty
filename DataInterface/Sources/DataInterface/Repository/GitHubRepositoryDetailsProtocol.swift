import Foundation
import DomainInterface

public protocol GitHubRepositoryDetailsProtocol {
    func fecthDetails(request: RequestProtocol, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void)
}
