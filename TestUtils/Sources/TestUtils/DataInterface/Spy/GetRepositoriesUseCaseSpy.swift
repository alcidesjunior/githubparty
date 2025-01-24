import DomainInterface

public final class GetRepositoriesUseCaseSpy: GetRepositoriesUseCasing {
    public private(set) var executeCalled = false
    public private(set) var pagePassed: Int?
    public private(set) var completionCalled = false
    public var completionToBeReturned: Result<GitHubResponse, Error>?
    
    public init() {}
    
    public func execute(page: Int, completion: @escaping (Result<GitHubResponse, Error>) -> Void) {
        executeCalled = true
        pagePassed = page
        if let result = completionToBeReturned {
            completionCalled = true
            completion(result)
        }
    }
}
