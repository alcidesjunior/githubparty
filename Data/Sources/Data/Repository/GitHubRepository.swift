import Foundation
import DataInterface
import DomainInterface

public final class GitHubRepository: GitHubRepositoryProtocol {
    private let service: GitHubServiceProtocol
    
    public init(service: GitHubServiceProtocol) {
        self.service = service
    }
    
    public func fecthGithubRepositories(request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        service.fecthGithubRepositories(request: request, completion: completion)
    }
}
