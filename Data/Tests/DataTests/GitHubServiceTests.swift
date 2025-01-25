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
        sut.fecthGithubRepositories(page: 1, request: requestStub) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(networkManagerSpy.executeCalled)
        
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
            XCTAssertEqual(networkManagerSpy.pagePassed, 1)
        default:
            XCTFail("Failed because we're expecting success")
        }
    }
    
    func test_fetchGitHubRepositories_whenFailed_shouldReturnFailResponse() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        networkManagerSpy.completionToBeReturned = .failure(ErrorDummy.genericError)
        
        var resultToBeCompared: Result<GitHubResponse, Error>?
        sut.fecthGithubRepositories(page: 1, request: requestStub) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(networkManagerSpy.executeCalled)
        
        switch resultToBeCompared {
        case .failure(let error):
            XCTAssertEqual(networkManagerSpy.pagePassed, 1)
            XCTAssertEqual(error as? ErrorDummy, ErrorDummy.genericError)
        default:
            XCTFail("Failed because we're expecting failure")
        }
    }
    
    func test_fetchGitHubRepositoryDetails_whenSucceed_shouldHaveCorrectData() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        let responseToBeCompared = [GitHubDetailsResponse.fixture()]
        networkManagerSpy.completionToBeReturned = .success(responseToBeCompared)
        
        var resultToBeCompared: Result<[GitHubDetailsResponse], Error>?
        sut.fecthGithubRepositoryDetails(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        XCTAssertTrue(networkManagerSpy.executeCalled)
        
        switch resultToBeCompared {
        case .success(let response):
            XCTAssertEqual(response, responseToBeCompared)
        default:
            XCTFail("Fail because we're expecting success")
        }
    }
    
    func test_fetchGitHubRepositoryDetails_whenFail() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        networkManagerSpy.completionToBeReturned = .failure(ErrorDummy.genericError)
        
        var resultToBeCompared: Result<[GitHubDetailsResponse], Error>?
        sut.fecthGithubRepositoryDetails(request: requestStub) { result in
            resultToBeCompared = result
        }
        
        switch resultToBeCompared {
        case .failure(let error):
            XCTAssertEqual(error as? ErrorDummy, .genericError)
        default:
            XCTFail("Fail because we're expecting failure value but got success")
        }
    }
}
