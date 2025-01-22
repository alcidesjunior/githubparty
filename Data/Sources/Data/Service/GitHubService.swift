import Foundation
import DataInterface
import DomainInterface

public final class GitHubService: GitHubServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    public func fecthGithubRepositories(request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        networkManager.execute(request: request) { result in
            completion(result)
        }
    }
}
