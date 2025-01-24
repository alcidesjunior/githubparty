import Domain
import DomainInterface
import TestUtils
import XCTest

@testable import HomeModule

final class HomeInteractorTests: XCTestCase {
    private let useCase = GetRepositoriesUseCaseSpy()
    private let itemsPerPage = 1
    private let presenterSpy = HomePresenterSpy()
    private lazy var sut: HomeBusinessLogic = {
        let interactor = HomeInteractor(
            getRepositoriesUseCase: useCase,
            itemsPerPage: itemsPerPage
        )
        interactor.presenter = presenterSpy
        return interactor
    }()
    
    func test_fetchRepositories_whenSucceed_shouldCallUseCase() {
        let responseToBeCompared: GitHubResponse = .fixture()
        let convertedResponseToViewModel: [HomeModel] = responseToBeCompared.items.map { .init(from: $0) }
        useCase.completionToBeReturned = .success(responseToBeCompared)
        sut.fetchRepositories()
        
        XCTAssertTrue(useCase.executeCalled)
        XCTAssertTrue(useCase.completionCalled)
        XCTAssertTrue(presenterSpy.displayRepositoriesCalled)
        XCTAssertTrue(presenterSpy.displayStartAnimationCalled)
        XCTAssertTrue(presenterSpy.displayStopAnimationCalled)
        XCTAssertTrue(presenterSpy.displayRepositoriesCalled)
        guard let viewModel = presenterSpy.displayRepositoriesPassed else {
            XCTFail("Fail when try to unwrap the viewModel")
            return
        }
        XCTAssertEqual(viewModel, convertedResponseToViewModel)
        XCTAssertEqual(useCase.pagePassed, 1)
    }
    
    func test_fetchRepositories_whenFails_shouldStopAnimation() {
        useCase.completionToBeReturned = .failure(ErrorDummy.genericError)
        sut.fetchRepositories()
        XCTAssertTrue(useCase.executeCalled)
        XCTAssertTrue(useCase.completionCalled)
        XCTAssertTrue(presenterSpy.displayStartAnimationCalled)
        XCTAssertTrue(presenterSpy.displayStopAnimationCalled)
        XCTAssertTrue(presenterSpy.displayErrorCalled)
        XCTAssertEqual(presenterSpy.displayErrorPassed, "The operation couldn’t be completed. (TestUtils.ErrorDummy error 2.)")
    }
}
