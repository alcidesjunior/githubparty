import Foundation

public protocol GetRepositoryDetailsUseCasing {
    func execute(with url: String, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void)
}
