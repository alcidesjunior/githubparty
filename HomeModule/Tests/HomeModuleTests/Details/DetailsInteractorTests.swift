import Domain
import DomainInterface
import XCTest
import TestUtils

@testable import HomeModule

final class DetailsInteractorTests: XCTestCase {
    private let useCaseSpy = GetRepositoryDetailsUseCaseSpy()
    private let presenterSpy = DetailsPresenterSpy()
    private lazy var sut: DetailsBusinessLogic = {
        let interactor = DetailsInteractor(getRepositoryDetailsUseCase: useCaseSpy)
        interactor.presenter = presenterSpy
        return interactor
    }()
    
    func test_fetchRepositoryDetails_whenCalled_andSucceed_andViewModelIsntEmpty_shouldCallDisplayRepositoryDetails() {
        let responseToBeCompared: [GitHubDetailsResponse] = [.fixture()]
        let convertedResponseToViewModel: [HomeDetailsModel] = responseToBeCompared.map { .init(from: $0) }
        useCaseSpy.executeToBeReturned = .success(responseToBeCompared)
        sut.fetchRepositoryDetails(with: "example.com")
        
        XCTAssertTrue(useCaseSpy.executeCalled)
        XCTAssertTrue(presenterSpy.displayRepositoryDetailsCalled)
        XCTAssertTrue(presenterSpy.displayStartAnimationCalled)
        XCTAssertTrue(presenterSpy.displayStopAnimationCalled)
        XCTAssertEqual(presenterSpy.displayRepositoryDetailsPassed, convertedResponseToViewModel)
    }
    
    func test_fetchRepositoryDetails_whenCalled_andSucceed_andViewModelIsEmpty_shoulNotdCallDisplayRepositoryDetails() {
        let responseToBeCompared: [GitHubDetailsResponse] = []
        useCaseSpy.executeToBeReturned = .success(responseToBeCompared)
        sut.fetchRepositoryDetails(with: "example.com")
        
        XCTAssertTrue(useCaseSpy.executeCalled)
        XCTAssertFalse(presenterSpy.displayRepositoryDetailsCalled)
        XCTAssertTrue(presenterSpy.displayStartAnimationCalled)
        XCTAssertTrue(presenterSpy.displayStopAnimationCalled)
        XCTAssertTrue(presenterSpy.displayEmptyStateCalled)
        XCTAssertNil(presenterSpy.displayRepositoryDetailsPassed)
    }
    
    func test_fetchRepositoryDetails_whenCalled_andFail_shoulNotdCallDisplayRepositoryDetails() {
        useCaseSpy.executeToBeReturned = .failure(ErrorDummy.genericError)
        sut.fetchRepositoryDetails(with: "example.com")
        
        XCTAssertTrue(useCaseSpy.executeCalled)
        XCTAssertFalse(presenterSpy.displayRepositoryDetailsCalled)
        XCTAssertTrue(presenterSpy.displayStartAnimationCalled)
        XCTAssertTrue(presenterSpy.displayStopAnimationCalled)
        XCTAssertTrue(presenterSpy.displayErrorCalled)
        XCTAssertNil(presenterSpy.displayRepositoryDetailsPassed)
    }
}
