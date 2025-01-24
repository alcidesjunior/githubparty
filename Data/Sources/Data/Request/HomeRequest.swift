import DataInterface
import Foundation

public struct HomeRequest: RequestProtocol {
    public var path: String = "/search/repositories"
    public var method: RequestMethod = .get
    public var encoding: RequestEncoding = .query
    public var body: Encodable? = ["q": "language:Swift", "sort": "stars", "order": "desc","per_page": ApiSetup.homeItemsPerPage.rawValue]
    public var headers: [String : String]?
    
    public init() {}
}
