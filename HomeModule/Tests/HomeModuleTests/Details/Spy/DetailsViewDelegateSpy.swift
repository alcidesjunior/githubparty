import HomeModule

final class DetailsViewDelegateSpy: DetailsViewDelegate {
    private(set) var didTapCellCalled = false
    private(set) var didTapCellPassed: String?
    
    func didTapCell(url: String) {
        didTapCellCalled = true
        didTapCellPassed = url
    }
    
    private(set) var displayErrorCalled = false
    private(set) var displayErrorPassed: String?
    
    func displayError(message: String) {
        displayErrorCalled = true
        displayErrorPassed = message
    }
}
