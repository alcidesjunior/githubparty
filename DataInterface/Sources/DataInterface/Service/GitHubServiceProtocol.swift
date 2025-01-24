import Foundation
import DomainInterface

public protocol GitHubServiceProtocol {
    func fecthGithubRepositories(page: Int, request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void)
}
