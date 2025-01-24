import XCTest

@testable import HomeModule

final class HomeViewControllerTests: XCTestCase {
    private let homeViewSpy = HomeViewSpy()
    private let homeInteractorSpy = HomeInteractorSpy()
    private lazy var sut: HomeViewController = {
        let controller = HomeViewController(
            homeView: homeViewSpy,
            interactor: homeInteractorSpy
        )
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
}
