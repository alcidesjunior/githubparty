import DataInterface
import Domain
import DomainInterface
import Foundation

public protocol HomeBusinessLogic {
    func fetchRepositories()
}

public final class HomeInteractor: HomeBusinessLogic {
    var presenter: HomeDisplayLogic?
    private let getRepositoriesUseCase: GetRepositoriesUseCasing
    private var currentPage: Int = 1
    private let itemsPerPage: Int
    
    public init(
        getRepositoriesUseCase: GetRepositoriesUseCasing,
        itemsPerPage: Int
    ) {
        self.getRepositoriesUseCase = getRepositoriesUseCase
        self.itemsPerPage = itemsPerPage
    }
    
    public func fetchRepositories() {
        presenter?.displayStartAnimation()
        getRepositoriesUseCase.execute(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let viewModel: [HomeModel] = response.items.map {
                    .init(from: $0)
                }
                self.presenter?.displayStopAnimation()
                self.presenter?.displayRepositories(viewModel)
                if viewModel.count > 0, viewModel.count >= self.itemsPerPage {
                    self.currentPage += 1
                }
            case .failure(let error):
                self.presenter?.displayStopAnimation()
                self.presenter?.displayError(message: error.localizedDescription)
                //TODO: The next step is to handle the errors
                break
            }
        }
    }
}

extension HomeModel {
    public init(from item: GitHubItem) {
        self = .init(
            repositoryName: item.name,
            description: item.description ?? "",
            profileImageUrl: item.owner.avatarUrl,
            profileName: item.owner.login,
            forkCount: item.forks,
            starCount: item.stars,
            reposUrl: item.pullsUrl
        )
    }
}
