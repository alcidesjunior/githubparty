import Domain
import HomeModule

public final class DetailsPresenterSpy: DetailsDisplayLogic {
    
    public private(set) var displayRepositoryDetailsCalled = false
    public private(set) var displayRepositoryDetailsPassed: [HomeDetailsModel]?
    
    public func displayRepositoryDetails(_ viewModel: [HomeDetailsModel]) {
        displayRepositoryDetailsCalled = true
        displayRepositoryDetailsPassed = viewModel
    }
    
    public private(set) var displayStartAnimationCalled = false
    
    public func displayStartAnimation() {
        displayStartAnimationCalled = true
    }
    
    public private(set) var displayStopAnimationCalled = false
    
    public func displayStopAnimation() {
        displayStopAnimationCalled = true
    }
    
    public private(set) var displayErrorCalled = false
    public private(set) var displayErrorPassed: String?
    
    public func displayError(message: String) {
        displayErrorCalled = true
        displayErrorPassed = message
    }
    
    public private(set) var displayEmptyStateCalled = false
    
    public func displayEmptyState() {
        displayEmptyStateCalled = true
    }
}
