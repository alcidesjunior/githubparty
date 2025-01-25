import HomeModule

public final class DetailsInteractorSpy: DetailsBusinessLogic {
    public private(set) var fetchRepositoryDetailsCalled = false
    public private(set) var fetchRepositoryDetailsPassed: String?
    
    public func fetchRepositoryDetails(with url: String) {
        fetchRepositoryDetailsCalled = true
        fetchRepositoryDetailsPassed = url
    }
}
