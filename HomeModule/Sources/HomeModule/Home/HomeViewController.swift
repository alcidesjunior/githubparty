import UIKit
import Utils

public final class HomeViewController: UIViewController, ViewController {
    private let homeView: HomeViewProtocol
    private let interactor: HomeBusinessLogic
    public weak var coordinator: Coordinator?
    
    public init(homeView: HomeViewProtocol, interactor: HomeBusinessLogic) {
        self.homeView = homeView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.homeView.delegate = self
        self.title = "Github Swift"
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    public override func loadView() {
        view = homeView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchRepositories()
    }
}

extension HomeViewController: HomeViewDelegate {
    public func loadMoreData() {
        interactor.fetchRepositories()
    }
    
    public func displayError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showToast(message: message, duration: 3.0, position: .top)
        }
    }
    
    public func didTapCell(reposUrl: String, repoName: String) {
        coordinator?.navigate(to: .details(reposUrl, repoName))
    }
}
