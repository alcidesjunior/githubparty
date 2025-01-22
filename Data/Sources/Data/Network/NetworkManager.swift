import DataInterface
import Foundation

final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    private let requestBuilder: RequestBuilderProtocol
    
    init(
        session: URLSession,
        jsonDecoder: JSONDecoder,
        requestBuilder: RequestBuilderProtocol
    ) {
        self.session = session
        self.jsonDecoder = jsonDecoder
        self.requestBuilder = requestBuilder
    }
    
    func execute<T: Codable>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        requestBuilder.setMethod(request.method)

        if let body = request.body {
            do {
                try requestBuilder.setBody(
                    body: body,
                    requestEncoding: request.encoding,
                    method: request.method
                )
            } catch let error {
                completion(.failure(NetworkError.failedToEncode(error)))
            }
        }
        
        if let headers = request.headers {
            requestBuilder.addHeaders(headers)
        }
        requestBuilder.setUrl(request.path)
        let urlRequest = requestBuilder.build()

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.genericError(error)))
                return
            }
            guard let jsonData = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            do {
                self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try self.jsonDecoder.decode(T.self, from: jsonData)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(NetworkError.failedToDecode(error)))
            }
        }
        task.resume()
    }
}
