import Domain
import XCTest
import TestUtils

@testable import HomeModule

final class DetailsPresenterTests: XCTestCase {
    private let viewSpy = DetailsViewSpy()
    private lazy var sut: DetailsDisplayLogic = {
        let presenter = DetailsPresenter()
        presenter.view = viewSpy
        return presenter
    }()
    
    func test_displayRepositoryDetails_whenCalled_shouldConfigureView() {
        let viewModel: [HomeDetailsModel] = [.fixture()]
        sut.displayRepositoryDetails(viewModel)
        
        XCTAssertTrue(viewSpy.configureCalled)
        XCTAssertEqual(viewSpy.configurePassed, viewModel)
    }
    
    func test_displayStartAnimation_whenCalled_shouldAnimateView() {
        sut.displayStartAnimation()
        
        XCTAssertTrue(viewSpy.startAnimationCalled)
    }
    
    func test_displayStopAnimation_whenCalled_shouldStopAnimationView() {
        sut.displayStopAnimation()
        
        XCTAssertTrue(viewSpy.stopAnimationCalled)
    }
    
    func test_displayError_whenCalled_shouldDisplayErrorView() {
        sut.displayError(message: "message")
        
        XCTAssertTrue(viewSpy.displayErrorCalled)
        XCTAssertEqual(viewSpy.displayErrorPassed, "message")
    }
    
    func test_displayEmptyState_whenCalled_shouldDisplayEmptyStateView() {
        sut.displayEmptyState()
        
        XCTAssertTrue(viewSpy.displayEmptyStateCalled)
    }
}
