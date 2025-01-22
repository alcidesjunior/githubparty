import Foundation
import DomainInterface

public protocol GitHubServiceProtocol {
    func fecthGithubRepositories(request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void)
}
