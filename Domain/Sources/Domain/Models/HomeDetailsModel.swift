public struct HomeDetailsModel: Equatable {
    public let title: String
    public let body: String
    public let htmlUrl: String
    public let login: String
    public let avatarUrl: String
    public let createdAt: String
    
    public init(
        title: String,
        body: String,
        htmlUrl: String,
        login: String,
        avatarUrl: String,
        createdAt: String
    ) {
        self.title = title
        self.body = body
        self.htmlUrl = htmlUrl
        self.login = login
        self.avatarUrl = avatarUrl
        self.createdAt = createdAt
    }
}
