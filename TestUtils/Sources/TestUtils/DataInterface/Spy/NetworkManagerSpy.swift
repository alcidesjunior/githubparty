import Foundation
import DataInterface
import DomainInterface

public final class NetworkManagerSpy: NetworkManagerProtocol {
    public private(set) var executeCalled = false
    public private(set) var requestPassed: RequestProtocol?
    public var completionToBeReturned: Result<Codable, Error>?
    public private(set) var pagePassed: Int?
    
    public init() {}
    
    public func execute<T: Codable>(page: Int = 0, request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        executeCalled = true
        requestPassed = request
        pagePassed = page
        guard let completionToReturn = completionToBeReturned else {
            return completion(.failure(ErrorDummy.completionCantBeNil))
        }

        switch completionToReturn {
        case .success(let codable):
            if let result = codable as? T {
                completion(.success(result))
            } else {
                completion(.failure(ErrorDummy.wrongTypePassed))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
