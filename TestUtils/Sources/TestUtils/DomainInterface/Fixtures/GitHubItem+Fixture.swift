import DomainInterface
import Foundation

public extension GitHubItem {
    static func fixture(
        id: Int = 1,
        name: String = "",
        description: String? = nil,
        stars: Int = 1,
        forks: Int = 1,
        owner: GitHubOwner = .fixture(),
        pullsUrl: String = ""
    ) -> Self {
        .init(
            id: id,
            name: name,
            description: description,
            stargazersCount: stars,
            forksCount: forks,
            owner: owner,
            pullsUrl: pullsUrl
        )
    }
}
