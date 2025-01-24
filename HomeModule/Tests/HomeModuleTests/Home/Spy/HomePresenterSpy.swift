import Domain
import HomeModule

final class HomePresenterSpy: HomeDisplayLogic {
    
    init() {}
    
    private(set) var displayRepositoriesCalled = false
    var displayRepositoriesPassed: [HomeModel]?
    
    func displayRepositories(_ viewModel: [HomeModel]) {
        displayRepositoriesCalled = true
        displayRepositoriesPassed = viewModel
    }
    
    private(set) var displayStartAnimationCalled = false
    
    func displayStartAnimation() {
        displayStartAnimationCalled = true
    }
    
    private(set) var displayStopAnimationCalled = false
    
    func displayStopAnimation() {
        displayStopAnimationCalled = true
    }
    
    private(set) var displayErrorCalled = false
    var displayErrorPassed: String?
    
    func displayError(message: String) {
        displayErrorCalled = true
        displayErrorPassed = message
    }
}
