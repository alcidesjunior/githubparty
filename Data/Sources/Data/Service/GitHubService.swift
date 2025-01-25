import Foundation
import DataInterface
import DomainInterface

public final class GitHubService: GitHubServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    public func fecthGithubRepositories(page: Int, request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        networkManager.execute(page: page, request: request) { result in
            completion(result)
        }
    }
    
    public func fecthGithubRepositoryDetails(request: RequestProtocol, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void) {
        networkManager.execute(page: 0, request: request, completion: completion)
    }
}
