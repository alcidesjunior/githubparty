import DomainInterface

public final class GetRepositoryDetailsUseCaseSpy: GetRepositoryDetailsUseCasing {
    public private(set) var executeCalled = false
    public private(set) var executePassed: String?
    public var executeToBeReturned: Result<[GitHubDetailsResponse], Error>?
    
    public init() {}
    
    public func execute(with url: String, completion: @escaping (Result<[GitHubDetailsResponse], Error>) -> Void) {
        executeCalled = true
        executePassed = url
        if let result = executeToBeReturned {
            completion(result)
        }
    }
}
