import HomeModule

final class HomeInteractorSpy: HomeBusinessLogic {
    private(set) var fetchRepositoriesCalled = false
    
    func fetchRepositories() {
        fetchRepositoriesCalled = true
    }
}
