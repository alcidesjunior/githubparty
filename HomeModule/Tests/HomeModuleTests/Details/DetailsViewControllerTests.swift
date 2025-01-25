import XCTest

@testable import HomeModule

final class DetailsViewControllerTests: XCTestCase {
    private let reposUrl = "example.com"
    private let reposName = "repo name"
    private let coordinatorSpy = MainCoordinatorSpy()
    private let interactorSpy = DetailsInteractorSpy()
    private let detailsViewSpy = DetailsViewSpy()
    private lazy var sut: DetailsViewController = {
        let viewController = DetailsViewController(
            reposUrl: reposUrl,
            repositoryName: reposName,
            interactor: interactorSpy,
            detailsView: detailsViewSpy
        )
        viewController.coordinator = coordinatorSpy
        return viewController
    }()
    
    func test_whenCalled_shouldSetInitials() {
        let _ = sut
        XCTAssertTrue(detailsViewSpy.delegateCalled)
    }
    
    func test_viewDidLoad_whenCalled() {
        sut.viewDidLoad()
        
        XCTAssertTrue(interactorSpy.fetchRepositoryDetailsCalled)
        XCTAssertEqual(interactorSpy.fetchRepositoryDetailsPassed, reposUrl)
    }
    
    func test_didTapCell_whenCalled_shouldCoordinateNavigator() {
        sut.didTapCell(url: reposUrl)
        
        XCTAssertTrue(coordinatorSpy.navigateCalled)
        XCTAssertEqual(coordinatorSpy.destinationPassed, .detailsWebView(reposUrl))
    }
}
