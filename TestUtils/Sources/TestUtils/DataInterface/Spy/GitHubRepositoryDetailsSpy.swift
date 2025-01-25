import DataInterface
import DomainInterface

public final class GitHubRepositoryDetailsSpy: GitHubRepositoryDetailsProtocol {
    public init() {}
    
    public private(set) var fecthDetailsCalled = false
    public private(set) var requestPassed: RequestProtocol?
    public var completionToBeReturned: Result<[GitHubDetailsResponse], Error>?
    
    public func fecthDetails(request: RequestProtocol, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void) {
        fecthDetailsCalled = true
        requestPassed = request
        if let result = completionToBeReturned {
            completion(result)
        }
    }
}
