import Data
import DataInterface
import DomainInterface
import Foundation

public final class GetUseCaseRepositoriesFactory {
    public static func make() -> GetRepositoriesUseCasing? {
        guard let url = URL(string: ApiSetup.baseURL.rawValue) else {
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
        let repository = GitHubRepository(service: service)
        let homeRequest = HomeRequest()
        let useCase = GetRepositoriesUseCase(
            repository: repository,
            request: homeRequest
        )
        
        return useCase
    }
}
