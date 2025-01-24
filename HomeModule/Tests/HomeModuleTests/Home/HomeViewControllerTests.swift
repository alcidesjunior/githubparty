import XCTest

@testable import HomeModule

final class HomeViewControllerTests: XCTestCase {
    private let homeViewSpy = HomeViewSpy()
    private let coordinatorSpy = MainCoordinatorSpy()
    private let homeInteractorSpy = HomeInteractorSpy()
    private lazy var sut: HomeViewController = {
        let controller = HomeViewController(
            homeView: homeViewSpy,
            interactor: homeInteractorSpy
        )
        controller.coordinator = coordinatorSpy
        return controller
    }()
    
    func test_viewDidLoad_whenCalled_shouldFetchRepositories() {
        sut.viewDidLoad()
        
        XCTAssertTrue(homeInteractorSpy.fetchRepositoriesCalled)
    }
    
    func test_loadMoreData_whenCalled_shouldFetchRepositories() {
        sut.loadMoreData()
        
        XCTAssertTrue(homeInteractorSpy.fetchRepositoriesCalled)
    }
    
    func test_didTapCell_whenCalled_shouldNavigateToDetails() {
        sut.didTapCell(reposUrl: "url", repoName: "name")
        
        XCTAssertTrue(coordinatorSpy.navigateCalled)
        XCTAssertEqual(coordinatorSpy.destinationPassed, .details("url", "name"))
    }
}
