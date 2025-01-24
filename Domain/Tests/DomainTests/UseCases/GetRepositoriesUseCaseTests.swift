import DomainInterface
import TestUtils
import XCTest

@testable import Domain

final class GetRepositoriesUseCaseTests: XCTestCase {
    private let repositorySpy = GitHubRepositorySpy()
    private let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
    private lazy var sut = GetRepositoriesUseCase(
        repository: repositorySpy,
        request: requestStub
    )
    
    func test_execute_whenSucceed_shouldReturnCorrectData() {
        let responseToBeCompared: GitHubResponse = .fixture()
        repositorySpy.completionToBeReturned = .success(responseToBeCompared)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.execute(page: 1) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(repositorySpy.fecthGithubRepositoriesCalled)
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
        default:
            XCTFail("Failed because we're expecting success")
        }
    }
    
    func test_execute_whenFail_shouldReturnCorrectData() {
        let errorToBeCompared: ErrorDummy = .genericError
        repositorySpy.completionToBeReturned = .failure(errorToBeCompared)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.execute(page: 1) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(repositorySpy.fecthGithubRepositoriesCalled)
        switch resultToBeCompared {
        case .failure(let error):
            XCTAssertEqual(error as? ErrorDummy, errorToBeCompared)
        default:
            XCTFail("Failed because we're expecting failure")
        }
    }
}
