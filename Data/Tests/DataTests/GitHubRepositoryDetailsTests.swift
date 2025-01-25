import DomainInterface
import TestUtils
import XCTest

@testable import Data

final class GitHubRepositoryDetailsTests: XCTestCase {
    private let serviceSpy = GitHubServiceSpy()
    private lazy var sut = GitHubRepositoryDetails(service: serviceSpy)
    
    func test_fetchDetails_shouldCallServicefecthGithubRepositoryDetails() {
        let responseToBeCompared: [GitHubDetailsResponse] = [.fixture()]
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        serviceSpy.fecthGithubRepositoryDetailsCompletionToBeReturned = .success(responseToBeCompared)
        
        var resultToBeCompared: Result<[GitHubDetailsResponse], Error>?
        sut.fecthDetails(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(serviceSpy.fecthGithubRepositoryDetailsCalled)
        
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
        default:
            XCTFail("Fail because we're expecting success")
        }
    }
    
    func test_fetchDetails_whenFail_shouldPassedCorrectValue() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        serviceSpy.fecthGithubRepositoryDetailsCompletionToBeReturned = .failure(ErrorDummy.genericError)
        
        var resultToBeCompared: Result<[GitHubDetailsResponse], Error>?
        sut.fecthDetails(request: requestStub) { result in
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
