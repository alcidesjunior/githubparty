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
    public let stargazersCount: Int
    public let forksCount: Int
    public let owner: GitHubOwner
    public let pullsUrl: String
    

    public var stars: Int { stargazersCount }
    public var forks: Int { forksCount }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case owner
        case pullsUrl = "pulls_url"
    }
    
    public init(
        id: Int,
        name: String,
        description: String?,
        stargazersCount: Int,
        forksCount: Int,
        owner: GitHubOwner,
        pullsUrl: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.stargazersCount = stargazersCount
        self.forksCount = forksCount
        self.owner = owner
        self.pullsUrl = pullsUrl
    }
}

public struct GitHubOwner: Codable, Equatable {
    public let login: String
    public let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        
    }
    
    public init(login: String, avatarUrl: String) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
