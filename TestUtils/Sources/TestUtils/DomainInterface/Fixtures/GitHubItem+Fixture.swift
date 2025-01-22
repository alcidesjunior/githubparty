import DomainInterface
import Foundation

public extension GitHubItem {
    static func fixture(
        id: Int = 1,
        name: String = "",
        description: String? = nil,
        stargazers_count: Int = 1,
        owner: GitHubOwner = .fixture()
    ) -> Self {
        .init(
            id: id,
            name: name,
            description: description,
            stargazers_count: stargazers_count,
            owner: owner
        )
    }
}
