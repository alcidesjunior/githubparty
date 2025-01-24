import HomeModule

final class HomeViewDelegateSpy: HomeViewDelegate {
    init() {}
    private(set) var loadMoreDataCalled = false
    
    func loadMoreData() {
        loadMoreDataCalled = true
    }
    
    private(set) var didTapCellCalled = false
    private(set) var didTapCellPassed: String?
    
    func didTapCell(reposUrl: String) {
        didTapCellCalled = true
        didTapCellPassed = reposUrl
    }
    
    private(set) var displayErrorCalled = false
    private(set) var displayErrorPassed: String?
    
    func displayError(message: String) {
        displayErrorCalled = true
        displayErrorPassed = message
    }
}
