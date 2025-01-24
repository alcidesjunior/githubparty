import Foundation
import DomainInterface

public protocol GitHubRepositoryProtocol {
    func fecthGithubRepositories(page: Int, request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void)
}
