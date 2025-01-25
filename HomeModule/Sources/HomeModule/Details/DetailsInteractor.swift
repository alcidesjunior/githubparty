import DataInterface
import Domain
import DomainInterface
import Foundation

public protocol DetailsBusinessLogic {
    func fetchRepositoryDetails(with url: String)
}

public final class DetailsInteractor: DetailsBusinessLogic {
    var presenter: DetailsDisplayLogic?
    private let getRepositoryDetailsUseCase: GetRepositoryDetailsUseCasing
    
    init(getRepositoryDetailsUseCase: GetRepositoryDetailsUseCasing) {
        self.getRepositoryDetailsUseCase = getRepositoryDetailsUseCase
    }
    
    public func fetchRepositoryDetails(with url: String) {
        presenter?.displayStartAnimation()
        getRepositoryDetailsUseCase.execute(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let viewModel: [HomeDetailsModel] = response.map { .init(from: $0) }
                self.presenter?.displayStopAnimation()
                if viewModel.isEmpty {
                    self.presenter?.displayEmptyState()
                } else {
                    self.presenter?.displayRepositoryDetails(viewModel)
                }
            case .failure(let error):
                self.presenter?.displayError(message: error.localizedDescription)
                self.presenter?.displayStopAnimation()
                break
            }
        }
    }
}

extension HomeDetailsModel {
    init(from item: GitHubDetailsResponse) {
        self = .init(
            title: item.title,
            body: item.body ?? "",
            htmlUrl: item.htmlUrl,
            login: item.user.login,
            avatarUrl: item.user.avatarUrl,
            createdAt: item.createdAt
        )
    }
}
