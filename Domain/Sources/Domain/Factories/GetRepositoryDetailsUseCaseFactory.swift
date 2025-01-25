import Data
import DataInterface
import DomainInterface
import Foundation

public final class GetRepositoryDetailsUseCaseFactory {
    public static func make(url: String) -> GetRepositoryDetailsUseCasing? {
        guard let url = URL(string: url) else {
            return nil
        }
        let request = URLRequest(url: url)
        let requestBuilder = RequestBuilder(
            urlRequest: request,
            encoder: JSONEncoder()
        )
        let networkManager = NetworkManager(
            session: URLSession.shared,
            jsonDecoder: JSONDecoder(),
            requestBuilder: requestBuilder
        )
        let service = GitHubService(networkManager: networkManager)
        let repository = GitHubRepositoryDetails(service: service)
        let useCase = GetRepositoryDetailsUseCase(
            repository: repository
        )
        
        return useCase
    }
}
