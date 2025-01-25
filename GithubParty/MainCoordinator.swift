import Foundation
import Utils
import UIKit
import HomeModule

    
public final class MainCoordinator: Coordinator {
    public weak var navigationController: UINavigationController?
        
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func navigate(to destination: NavigationDestination) {
        switch destination {
        case .home:
            guard let viewController: ViewController = HomeConfigurator.make() else { return }
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
        case .details(let reposUrl, let repoName):
            guard let viewController = DetailsConfigurator.make(reposUrl: reposUrl, repositoryName: repoName) else { return }
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
            break
        case .detailsWebView(let url):
            let viewController = DetailsWebViewController(url: url)
            viewController.coordinator = self
            navigationController?.present(viewController, animated: true)
        case .pop:
            navigationController?.popViewController(animated: true)
        case .dismiss:
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
