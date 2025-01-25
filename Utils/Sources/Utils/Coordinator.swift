import Foundation
import UIKit

public enum NavigationDestination: Equatable {
    case home
    case details(_ reposUrl: String, _ repositoryName: String)
    case detailsWebView(_ url: String)
    case pop
    case dismiss
}

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }

    func navigate(to destination: NavigationDestination)
}

public protocol ViewController: UIViewController {
    var coordinator: Coordinator? { get set }
}
