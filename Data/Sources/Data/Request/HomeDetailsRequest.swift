import DataInterface
import Foundation

public struct HomeDetailsRequest: RequestProtocol {
    public var path: String
    public var method: RequestMethod
    public var encoding: RequestEncoding
    public var body: Encodable?
    public var headers: [String : String]?
    
    public init(
        path: String,
        method: RequestMethod,
        encoding: RequestEncoding,
        body: Encodable? = nil,
        headers: [String : String]? = nil
    ) {
        self.path = path
        self.method = method
        self.encoding = encoding
        self.body = body
        self.headers = headers
    }
}
