import HomeModule

final class HomeViewDelegateSpy: HomeViewDelegate {
    init() {}
    private(set) var loadMoreDataCalled = false
    
    func loadMoreData() {
        loadMoreDataCalled = true
    }
    
    private(set) var didTapCellCalled = false
    private(set) var didTapCellPassed: String?
    private(set) var didTapCellRepoNamePassed: String?
    
    func didTapCell(reposUrl: String, repoName: String) {
        didTapCellCalled = true
        didTapCellPassed = reposUrl
        didTapCellRepoNamePassed = repoName
    }
    
    private(set) var displayErrorCalled = false
    private(set) var displayErrorPassed: String?
    
    func displayError(message: String) {
        displayErrorCalled = true
        displayErrorPassed = message
    }
}
