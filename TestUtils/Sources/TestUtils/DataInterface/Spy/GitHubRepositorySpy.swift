import DataInterface
import DomainInterface
import Foundation

public final class GitHubRepositorySpy: GitHubRepositoryProtocol {
    public private(set) var fecthGithubRepositoriesCalled = false
    public private(set) var requestPassed: RequestProtocol?
    public var completionToBeReturned: Result<GitHubResponse, Error>?
    
    public init() {}
    
    public func fecthGithubRepositories(request: RequestProtocol, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        fecthGithubRepositoriesCalled = true
        requestPassed = request
        
        if let result = completionToBeReturned {
            completion(result)
        }
    }
}
