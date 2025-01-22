import Foundation

public struct GitHubResponse: Codable, Equatable {
    public let items: [GitHubItem]
    
    public init(items: [GitHubItem]) {
        self.items = items
    }
}

public struct GitHubItem: Codable, Equatable {
    public let id: Int
    public let name: String
    public let description: String?
    public let stargazers_count: Int
    public let owner: GitHubOwner

    public var stars: Int { stargazers_count }
    
    public init(
        id: Int,
        name: String,
        description: String?,
        stargazers_count: Int,
        owner: GitHubOwner
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.stargazers_count = stargazers_count
        self.owner = owner
    }
}

public struct GitHubOwner: Codable, Equatable {
    public let login: String
    public let avatar_url: String
    
    public init(login: String, avatar_url: String) {
        self.login = login
        self.avatar_url = avatar_url
    }
}
