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
            let viewController = DetailsViewController(reposUrl: reposUrl, repositoryName: repoName)
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
            break
        case .pop:
            navigationController?.popViewController(animated: true)
        case .dismiss:
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
