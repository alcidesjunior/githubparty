import DomainInterface
import TestUtils
import XCTest

@testable import Data

final class GitHubServiceTests: XCTestCase {
    private let networkManagerSpy = NetworkManagerSpy()
    private lazy var sut = GitHubService(networkManager: networkManagerSpy)
    
    func test_fecthGithubRepositories_whenSucceed_shouldReturnGitHubResponse() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        let responseToBeCompared = GitHubResponse.fixture()
        networkManagerSpy.completionToBeReturned = .success(responseToBeCompared)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.fecthGithubRepositories(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(networkManagerSpy.executeCalled)
        
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
        default:
            XCTFail("Failed because we're expecting success")
        }
    }
    
    func test_fetchGitHubRepositories_whenFailed_shouldReturnFailResponse() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        networkManagerSpy.completionToBeReturned = .failure(ErrorDummy.genericError)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.fecthGithubRepositories(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(networkManagerSpy.executeCalled)
        
        switch resultToBeCompared {
        case .failure(let error):
            XCTAssertEqual(error as? ErrorDummy, ErrorDummy.genericError)
        default:
            XCTFail("Failed because we're expecting failure")
        }
    }
}
