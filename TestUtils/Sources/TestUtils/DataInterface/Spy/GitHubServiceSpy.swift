import DataInterface
import DomainInterface
import Foundation

public final class GitHubServiceSpy: GitHubServiceProtocol {
    public private(set) var fecthGithubRepositoriesCalled = false
    public private(set) var requestPassed: RequestProtocol?
    public var completionToBeReturned: Result<GitHubResponse, Error>?
    public private(set) var pagePassed: Int?
    
    public init() {}
    
    public func fecthGithubRepositories(page: Int = 0, request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        fecthGithubRepositoriesCalled = true
        pagePassed = page
        if let result = completionToBeReturned {
            completion(result)
        }
    }
}
