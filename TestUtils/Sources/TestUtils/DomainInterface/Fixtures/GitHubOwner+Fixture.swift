import DomainInterface
import Foundation

public extension GitHubOwner {
    static func fixture(login: String = "", avatar_url: String = "") -> Self {
        .init(login: login, avatarUrl: avatar_url)
    }
}
