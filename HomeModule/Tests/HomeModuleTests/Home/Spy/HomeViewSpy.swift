import Domain
import HomeModule
import UIKit

final class HomeViewSpy: UIView, HomeViewProtocol {
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    var delegate: HomeViewDelegate?
    
    private(set) var configureCalled = false
    private(set) var configurePassed: [HomeModel]?
    
    func configure(with dataSource: [HomeModel]) {
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
}
