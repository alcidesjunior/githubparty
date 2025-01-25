import Domain

public protocol DetailsDisplayLogic {
    func displayRepositoryDetails(_ viewModel: [HomeDetailsModel])
    func displayStartAnimation()
    func displayStopAnimation()
    func displayError(message: String)
    func displayEmptyState()
}

public final class DetailsPresenter: DetailsDisplayLogic {
    weak var view: DetailsViewProtocol?
    
    public func displayRepositoryDetails(_ viewModel: [HomeDetailsModel]) {
        let viewModel: [HomeDetailsModel] = viewModel.map {
            .init(
                title: $0.title,
                body: $0.body,
                htmlUrl: $0.htmlUrl,
                login: $0.login,
                avatarUrl: $0.avatarUrl,
                createdAt: $0.createdAt.toFormattedDate() ?? ""
            )
        }
        view?.configure(with: viewModel)
    }
    
    public func displayStartAnimation() {
        view?.startAnimation()
    }
    
    public func displayStopAnimation() {
        view?.stopAnimation()
    }
    
    public func displayError(message: String) {
        view?.displayError(message: message)
    }
    
    public func displayEmptyState() {
        view?.displayEmptyState()
    }
}
