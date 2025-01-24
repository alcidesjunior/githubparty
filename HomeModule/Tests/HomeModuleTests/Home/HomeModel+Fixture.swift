import Domain

public extension HomeModel {
    static func fixture(
        repositoryName: String = "",
        description: String = "",
        profileImageUrl: String = "",
        profileName: String = "",
        forkCount: Int = 0,
        starCount: Int = 0,
        reposUrl: String = ""
    ) -> Self {
        .init(
            repositoryName: repositoryName,
            description: description,
            profileImageUrl: profileImageUrl,
            profileName: profileName,
            forkCount: forkCount,
            starCount: starCount,
            reposUrl: reposUrl
        )
    }
}
