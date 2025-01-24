import Foundation

public protocol GetRepositoriesUseCasing {
    func execute(page: Int, completion: @escaping (Result<GitHubResponse, Error>) -> Void)
}
