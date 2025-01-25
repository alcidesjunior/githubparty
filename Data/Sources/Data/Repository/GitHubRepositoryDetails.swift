import DataInterface
import DomainInterface

public final class GitHubRepositoryDetails: GitHubRepositoryDetailsProtocol {
    private let service: GitHubServiceProtocol
    
    public init(service: GitHubServiceProtocol) {
        self.service = service
    }

    public func fecthDetails(request: RequestProtocol, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void) {
        service.fecthGithubRepositoryDetails(request: request, completion: completion)
    }
}
