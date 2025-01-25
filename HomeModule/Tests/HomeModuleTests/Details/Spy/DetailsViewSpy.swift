import Domain
import HomeModule
import UIKit

final class DetailsViewSpy: UIView, DetailsViewProtocol {
    private(set) var delegateCalled = false
    var delegate: DetailsViewDelegate? {
        didSet {
            delegateCalled = true
        }
    }
    
    private(set) var configureCalled = false
    private(set) var configurePassed: [HomeDetailsModel]?
    
    func configure(with dataSource: [HomeDetailsModel]) {
        configureCalled = true
        configurePassed = dataSource
    }
    
    private(set) var startAnimationCalled = false
    
    func startAnimation() {
        startAnimationCalled = true
    }
    
    private(set) var stopAnimationCalled = false
    
    func stopAnimation() {
        stopAnimationCalled = true
    }
    
    private(set) var displayErrorCalled = false
    private(set) var displayErrorPassed: String?
    
    func displayError(message: String) {
        displayErrorCalled = true
        displayErrorPassed = message
    }
    
    private(set) var displayEmptyStateCalled = false
    
    func displayEmptyState() {
        displayEmptyStateCalled = true
    }
}
