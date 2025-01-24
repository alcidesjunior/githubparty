public struct HomeModel: Equatable {
    public let repositoryName: String
    public let description: String
    public let profileImageUrl: String
    public let profileName: String
    public let forkCount: Int
    public let starCount: Int
    public let reposUrl: String
    
    public init(
        repositoryName: String,
        description: String,
        profileImageUrl: String,
        profileName: String,
        forkCount: Int,
        starCount: Int,
        reposUrl: String
    ) {
        self.repositoryName = repositoryName
        self.description = description
        self.profileImageUrl = profileImageUrl
        self.profileName = profileName
        self.forkCount = forkCount
        self.starCount = starCount
        self.reposUrl = reposUrl
    }
}
