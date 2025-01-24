import HomeModule
import XCTest

@testable import GithubParty

final class MainCoordinatorTests: XCTestCase {
    private let navigationSpy = NavigationControllerSpy()
    private lazy var sut = MainCoordinator(navigationController: navigationSpy)
    
    func testNavigateToHome_PushesHomeViewController() {
        sut.navigate(to: .home)
        
        XCTAssertNotNil(navigationSpy.pushedViewController)
        XCTAssertTrue(navigationSpy.pushedViewController is HomeViewController)
    }

    func testNavigateToDetails_PushesDetailsViewController() {
        let expectedUrl = "https://api.github.com/repos"
        let expectedRepoName = "MyRepo"
        
        sut.navigate(to: .details(expectedUrl, expectedRepoName))
        
        XCTAssertNotNil(navigationSpy.pushedViewController)
        XCTAssertTrue(navigationSpy.pushedViewController is DetailsViewController)
        let detailsVC = navigationSpy.pushedViewController as? DetailsViewController
    }

    func testNavigateToPop_PopsViewController() {
        sut.navigate(to: .pop)
        
        XCTAssertTrue(navigationSpy.poppedViewController)
    }

    func testNavigateToDismiss_DismissesViewController() {
        sut.navigate(to: .dismiss)
        
        XCTAssertTrue(navigationSpy.dismissedViewController)
    }
}
