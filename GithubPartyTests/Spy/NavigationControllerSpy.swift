import UIKit

final class NavigationControllerSpy: UINavigationController {
    private(set) var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    private(set) var poppedViewController: Bool = false
    
    override func popViewController(animated: Bool) -> UIViewController? {
        poppedViewController = true
        return super.popViewController(animated: animated)
    }
    
    private(set) var dismissedViewController: Bool = false
    
    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        dismissedViewController = true
        super.dismiss(animated: animated, completion: completion)
    }
}
