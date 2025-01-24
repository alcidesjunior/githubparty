import DataInterface
import Domain
import UIKit

public final class HomeConfigurator {
    public static func make() -> UIViewController? {
        let homeView = HomeView()
        guard let getRepositoriesUseCase = GetUseCaseRepositoriesFactory.make() else {
            return nil
        }
        let presenter = HomePresenter()
        presenter.view = homeView
        let interactor = HomeInteractor(
            getRepositoriesUseCase: getRepositoriesUseCase,
            itemsPerPage: Int(ApiSetup.homeItemsPerPage.rawValue) ?? 1
        )
        interactor.presenter = presenter
        let homeViewController = HomeViewController(
            homeView: homeView,
            interactor: interactor
        )
        return homeViewController
    }
}
