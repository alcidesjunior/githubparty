import DataInterface
import Foundation

public final class RequestBuilder: RequestBuilderProtocol {
    private var urlRequest: URLRequest
    private let encoder: JSONEncoder
    
    public init(urlRequest: URLRequest, encoder: JSONEncoder) {
        self.urlRequest = urlRequest
        self.encoder = encoder
    }
    
    public func setMethod(_ method: RequestMethod) {
        urlRequest.httpMethod = method.rawValue
    }
    
    public func addHeaders(_ headers: [String : String]) {
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    public func setBody<T: Encodable>(body: T?, requestEncoding: RequestEncoding, method: RequestMethod) throws {
        switch requestEncoding {
        case .json:
            if method == .post || method == .put || method == .patch {
                if let body = body {
                    let encodedBody = try encoder.encode(body)
                    urlRequest.httpBody = encodedBody
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
                }
            }
        case .query:
            if method == .get || method == .delete {
                if let body = body as? [String: Any] {
                    var queryItems = [URLQueryItem]()
                    for (key, value) in body {
                        let queryItem = URLQueryItem(name: key, value: "\(value)")
                        queryItems.append(queryItem)
                    }
                    
                    guard let url = urlRequest.url else {
                        throw NetworkError.invalidURL
                    }
                    
                    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
                    urlComponents?.queryItems = queryItems
                    
                    if let finalUrl = urlComponents?.url {
                        urlRequest.url = finalUrl
                    }
                }
            }
        }
    }
    
    public func setUrl(_ path: String) {
        guard let url = urlRequest.url?.absoluteString, url.contains(path), !path.isEmpty else {
            urlRequest.url = urlRequest.url?.appendingPathComponent(path)
            return
        }
    }
    
    public func build() -> URLRequest {
        return urlRequest
    }
}
