import DomainInterface
import XCTest
import TestUtils

@testable import Domain

final class GetRepositoryDetailsUseCaseTests: XCTestCase {
    private let repositorySpy = GitHubRepositoryDetailsSpy()
    private lazy var sut = GetRepositoryDetailsUseCase(repository: repositorySpy)
    
    func test_execute_whenSucceed_shouldReturnCorrectData() {
        let url = "example.com"
        let responseToBeCompared: [GitHubDetailsResponse] = [.fixture()]
        repositorySpy.completionToBeReturned = .success(responseToBeCompared)
        
        var resultToBeCompared: Result<[GitHubDetailsResponse], Error>?
        sut.execute(with: url) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(repositorySpy.fecthDetailsCalled)
        
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
        default:
            XCTFail("Fail because we're expecting success")
        }
    }
    
    func test_execute_whenFail_shouldReturnCorrectData() {
        let errorToBeCompared: ErrorDummy = .genericError
        let url = "example.com"
        repositorySpy.completionToBeReturned = .failure(errorToBeCompared)
        
        var resultToBeCompared: Result<[GitHubDetailsResponse], Error>?
        sut.execute(with: url) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(repositorySpy.fecthDetailsCalled)
        switch resultToBeCompared {
        case .failure(let error):
            XCTAssertEqual(error as? ErrorDummy, errorToBeCompared)
        default:
            XCTFail("Failed because we're expecting failure")
        }
    }
}
