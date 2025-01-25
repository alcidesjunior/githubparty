import Data
import DataInterface
import DomainInterface

public final class GetRepositoryDetailsUseCase: GetRepositoryDetailsUseCasing {
    private let repository: GitHubRepositoryDetailsProtocol
    
    public init(
        repository: GitHubRepositoryDetailsProtocol
    ) {
        self.repository = repository
    }
    
    public func execute(with url: String, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void) {
        let request = HomeDetailsRequest(path: url, method: .get, encoding: .query)
        repository.fecthDetails(request: request, completion: completion)
    }
}
