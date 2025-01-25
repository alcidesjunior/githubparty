import Foundation

public struct GitHubDetailsResponse: Codable, Equatable {
    public let title: String
    public let body: String?
    public let htmlUrl: String
    public let user: User
    public let createdAt: String
    
    public enum CodingKeys: String, CodingKey {
        case title
        case body
        case htmlUrl = "html_url"
        case user
        case createdAt = "created_at"
    }
    
    public init(title: String, body: String?, htmlUrl: String, user: User, createdAt: String) {
        self.title = title
        self.body = body
        self.htmlUrl = htmlUrl
        self.user = user
        self.createdAt = createdAt
    }
}

public struct User: Codable, Equatable {
    public let login: String
    public let avatarUrl: String
    
    public enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
    public init(login: String, avatarUrl: String) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
