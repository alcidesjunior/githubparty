import Domain
import Foundation

public protocol HomeDisplayLogic: AnyObject {
    func displayRepositories(_ viewModel: [HomeModel])
    func displayStartAnimation()
    func displayStopAnimation()
    func displayError(message: String)
}

public final class HomePresenter: HomeDisplayLogic {
    weak var view: HomeViewProtocol?
    
    public func displayRepositories(_ viewModel: [HomeModel]) {
        let viewModel: [HomeModel] = viewModel.map {
            .init(
                repositoryName: $0.repositoryName,
                description: $0.description,
                profileImageUrl: $0.profileImageUrl,
                profileName: $0.profileName,
                forkCount: $0.forkCount,
                starCount: $0.forkCount,
                reposUrl: $0.reposUrl.replacingOccurrences(of: "{/number}", with: "")
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
}
