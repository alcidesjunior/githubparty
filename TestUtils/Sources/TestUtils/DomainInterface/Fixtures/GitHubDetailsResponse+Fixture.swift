import DomainInterface

public extension GitHubDetailsResponse {
    static func fixture(
        title: String = "",
        body: String = "",
        htmlUrl: String = "",
        user: User = .fixture(),
        createdAt: String = ""
    ) -> Self {
        .init(
            title: title,
            body: body,
            htmlUrl: htmlUrl,
            user: .fixture(),
            createdAt: createdAt
        )
    }
}

public extension User {
    static func fixture(
        login: String = "",
        avatarUrl: String = ""
    ) -> Self {
        .init(login: login, avatarUrl: avatarUrl)
    }
}
