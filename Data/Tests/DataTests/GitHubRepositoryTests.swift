import Data
import DomainInterface
import TestUtils
import XCTest

final class GitHubRepositoryTests: XCTestCase {
    private let serviceSpy = GitHubServiceSpy()
    private lazy var sut = GitHubRepository(service: serviceSpy)
    
    func test_fecthGithubRepositories_whenSucceed_shouldPassedCorrectValue() {
        let responseToBeCompared: GitHubResponse = .fixture()
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        serviceSpy.completionToBeReturned = .success(responseToBeCompared)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.fecthGithubRepositories(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
        default:
            XCTFail("Expecting success")
        }
    }
    
    func test_fecthGithubRepositories_whenFail_shouldPassedCorrectValue() {
        let responseToBeCompared: GitHubResponse = .fixture()
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        serviceSpy.completionToBeReturned = .failure(ErrorDummy.genericError)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.fecthGithubRepositories(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        switch resultToBeCompared {
        case .failure(let error):
            XCTAssertEqual(error as? ErrorDummy, .genericError)
        default:
            XCTFail("Expecting failure")
        }
    }
}
