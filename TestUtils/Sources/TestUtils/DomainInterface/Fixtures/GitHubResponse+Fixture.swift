import DomainInterface
import Foundation

public extension GitHubResponse {
    static func fixture(items: [GitHubItem] = [.fixture()]) -> Self {
        .init(items: items)
    }
}
