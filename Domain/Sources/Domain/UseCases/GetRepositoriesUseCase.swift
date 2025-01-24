import DataInterface
import DomainInterface
import Foundation

public final class GetRepositoriesUseCase: GetRepositoriesUseCasing {
    private let repository: GitHubRepositoryProtocol
    private let request: RequestProtocol
    
    public init(
        repository: GitHubRepositoryProtocol,
        request: RequestProtocol
    ) {
        self.repository = repository
        self.request = request
    }
    
    public func execute(page: Int, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        repository.fecthGithubRepositories(page: page, request: request) { result in
            completion(result)
        }
    }
}
