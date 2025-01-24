import Utils
import UIKit

final class MainCoordinatorSpy: Coordinator {
    var navigationController: UINavigationController?
    
    private(set) var navigateCalled = false
    private(set) var destinationPassed: NavigationDestination?
    
    init() {}
    
    func navigate(to destination: NavigationDestination) {
        navigateCalled = true
        destinationPassed = destination
    }
}
