import Foundation

public protocol GetRepositoriesUseCasing {
    func execute(completion: @escaping (Result<GitHubResponse, Error>) -> Void)
}
