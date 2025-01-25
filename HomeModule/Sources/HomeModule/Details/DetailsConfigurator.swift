import DataInterface
import Domain
import UIKit
import Utils

public final class DetailsConfigurator {
    public static func make(reposUrl: String, repositoryName: String) -> ViewController? {
        let detailsView = DetailsView()
        guard let getRepositoryDetailsUseCase = GetRepositoryDetailsUseCaseFactory.make(url: reposUrl) else {
            return nil
        }
        let presenter = DetailsPresenter()
        presenter.view = detailsView
        let interactor = DetailsInteractor(
            getRepositoryDetailsUseCase: getRepositoryDetailsUseCase
        )
        interactor.presenter = presenter
        let homeViewController = DetailsViewController(
            reposUrl: reposUrl,
            repositoryName: repositoryName,
            interactor: interactor,
            detailsView: detailsView
        )
        return homeViewController
    }
}
