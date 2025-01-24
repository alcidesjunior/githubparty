import Foundation
import DataInterface
import DomainInterface

public final class GitHubRepository: GitHubRepositoryProtocol {
    private let service: GitHubServiceProtocol
    
    public init(service: GitHubServiceProtocol) {
        self.service = service
    }
    
    public func fecthGithubRepositories(page: Int, request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        service.fecthGithubRepositories(page: page, request: request, completion: completion)
    }
}
