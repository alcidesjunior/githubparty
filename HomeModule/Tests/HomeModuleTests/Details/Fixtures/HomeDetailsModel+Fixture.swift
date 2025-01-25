import Domain

public extension HomeDetailsModel {
    static func fixture(
        title: String = "",
        body: String = "",
        htmlUrl: String = "",
        login: String = "",
        avatarUrl: String = "",
        createdAt: String = ""
    ) -> Self {
        .init(
            title: title,
            body: body,
            htmlUrl: htmlUrl,
            login: login,
            avatarUrl: avatarUrl,
            createdAt: createdAt
        )
    }
}
