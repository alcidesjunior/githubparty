import Foundation
import DomainInterface

public protocol GitHubRepositoryProtocol {
    func fecthGithubRepositories(request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void)
}
