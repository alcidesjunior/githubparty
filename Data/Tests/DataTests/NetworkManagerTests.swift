import XCTest
import DataInterface
import TestUtils

@testable import Data

final class NetworkManagerTests: XCTestCase {
    private let urlSessionStub = URLSessionStub()
    private let jsonDecoderSpy = JSONDecoderSpy()
    private let requestBuilderSpy = RequestBuilderSpy()
    
    private lazy var sut = NetworkManager(
        session: urlSessionStub,
        jsonDecoder: jsonDecoderSpy,
        requestBuilder: requestBuilderSpy
    )
    
    func test_execute_decodesResponseToDataModelDummy() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        let jsonResponse = "{\"name\": \"Alcides\", \"age\": 30}"

        guard let mockResponseData = jsonResponse.data(using: .utf8) else {
            XCTFail("Fail when try to encode mock response data")
            return
        }
        
        guard let url = URL(string: "https://example.com") else {
            XCTFail("Error when try unwrap url")
            return
        }
        
        let validResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        urlSessionStub.responseToReturn = validResponse
        urlSessionStub.dataToReturn = mockResponseData
        
        let expectedDecodedResponse = DataModelDummy(name: "Alcides", age: 30)
        
        var result: Result<DataModelDummy, Error>?
        
        sut.execute(request: requestStub) { response in
            result = response
        }
        
        guard let unwrappedResult = result else {
            XCTFail("Result was not set")
            return
        }
        
        switch unwrappedResult {
        case .success(let decodedResponse):
            XCTAssertEqual(decodedResponse.name, expectedDecodedResponse.name)
            XCTAssertEqual(decodedResponse.age, expectedDecodedResponse.age)
        case .failure(let error):
            XCTFail("Expected success, but got failure: \(error)")
        }
    }
    
    func test_execute_handlesNoDataError() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        urlSessionStub.dataToReturn = nil
        
        guard let url = URL(string: "https://example.com") else {
            XCTFail("Error when try unwrap url")
            return
        }
        
        let validResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        urlSessionStub.responseToReturn = validResponse
        
        var result: Result<DataModelDummy, Error>?
        
        sut.execute(request: requestStub) { response in
            result = response
        }
        
        guard let unwrappedResult = result else {
            XCTFail("Result was not set")
            return
        }
        
        switch unwrappedResult {
        case .failure(let error):
            XCTAssertEqual(error as? NetworkError, NetworkError.noData)
        case .success:
            XCTFail("Expected failure, but got success")
        }
    }
    
    func test_execute_handlesInvalidResponseError() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        let jsonResponse = "{\"name\": \"Alcides\", \"age\": 30}"
        guard let mockResponseData = jsonResponse.data(using: .utf8) else {
            XCTFail("Fail when try to encode mock response data")
            return
        }
        urlSessionStub.dataToReturn = mockResponseData
        
        guard let url = URL(string: "https://example.com") else {
            XCTFail("Error when try unwrap url")
            return
        }
        
        let invalidResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        urlSessionStub.responseToReturn = invalidResponse
        
        var result: Result<DataModelDummy, Error>?
        
        sut.execute(request: requestStub) { response in
            result = response
        }
        
        guard let unwrappedResult = result else {
            XCTFail("Result was not set")
            return
        }
        
        switch unwrappedResult {
        case .failure(let error):
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        case .success:
            XCTFail("Expected failure, but got success")
        }
    }
    
    func test_execute_handlesGenericError() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        urlSessionStub.errorToReturn = NSError(domain: "com.example", code: 123, userInfo: nil)
        let mockError = NSError(domain: "com.example", code: 123, userInfo: nil)
        var result: Result<DataModelDummy, Error>?
        sut.execute(request: requestStub) { response in
            result = response
        }
        
        guard let unwrappedResult = result else {
            XCTFail("Result was not set")
            return
        }
        
        switch unwrappedResult {
        case .failure(let error):
            XCTAssertEqual(error as? NetworkError, NetworkError.genericError(mockError))
        case .success:
            XCTFail("Expected failure, but got success")
        }
    }
    
    func test_execute_handlesFailedToDecodeError() {
        let requestStub = RequestProtocolStub(path: "example.com", method: .get, encoding: .json)
        urlSessionStub.dataToReturn = Data()
        let mockError = NSError(domain: "com.example", code: 123, userInfo: nil)
        guard let url = URL(string: "https://example.com") else {
            XCTFail("Error when try unwrap url")
            return
        }
        urlSessionStub.responseToReturn = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        jsonDecoderSpy.errorToBeThrow = mockError
        var result: Result<DataModelDummy, Error>?
        sut.execute(request: requestStub) { response in
            result = response
        }
        
        guard let unwrappedResult = result else {
            XCTFail("Result was not set")
            return
        }
        
        switch unwrappedResult {
        case .failure(let error):
            XCTAssertEqual(error as? NetworkError, NetworkError.failedToDecode(mockError))
        case .success:
            XCTFail("Expected failure, but got success")
        }
    }
}
