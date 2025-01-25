import Domain
import DomainInterface
import TestUtils
import XCTest

@testable import HomeModule

final class HomePresenterTests: XCTestCase {
    private let delegateSpy = HomeViewDelegateSpy()
    private lazy var viewSpy: HomeViewSpy = {
        let view = HomeViewSpy()
        view.delegate = delegateSpy
        return view
    }()
    private lazy var sut: HomeDisplayLogic = {
        let presenter = HomePresenter()
        presenter.view = viewSpy
        return presenter
    }()
    
    func test_displayRepositories_whenCalled_shouldConfigureView() {
        let viewModelToBeCompared: [HomeModel] = [.fixture(reposUrl: "example.com/{/number}")]
        sut.displayRepositories(viewModelToBeCompared)
        
        XCTAssertTrue(viewSpy.configureCalled)
        XCTAssertEqual(viewSpy.configurePassed, [.fixture(reposUrl: "example.com/")])
    }
    
    func test_displayStartAnimation_whenCalled_shouldStartAnimationView() {
        sut.displayStartAnimation()
        
        XCTAssertTrue(viewSpy.startAnimationCalled)
    }
    
    func test_displayStopAnimation_whenCalled_shouldStopAnimationView() {
        sut.displayStopAnimation()
        
        XCTAssertTrue(viewSpy.stopAnimationCalled)
    }
    
    func test_displayError_whenCalled_shouldDisplayErrorView() {
        sut.displayError(message: "error")
        
        XCTAssertTrue(viewSpy.displayErrorCalled)
        XCTAssertEqual(viewSpy.displayErrorPassed, "error")
    }
}
