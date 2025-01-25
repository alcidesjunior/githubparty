import UIKit
import Utils

public final class DetailsViewController: UIViewController, ViewController {
    public weak var coordinator: Coordinator?
    private let detailsView: DetailsViewProtocol
    private let reposUrl: String
    private let repositoryName: String
    private let interactor: DetailsBusinessLogic
    
    public init(
        reposUrl: String,
        repositoryName: String,
        interactor: DetailsBusinessLogic,
        detailsView: DetailsViewProtocol
    ) {
        self.reposUrl = reposUrl
        self.repositoryName = repositoryName
        self.interactor = interactor
        self.detailsView = detailsView
        super.init(nibName: nil, bundle: nil)
        self.detailsView.delegate = self
        self.title = repositoryName
    }
    
    public override func loadView() {
        view = detailsView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchRepositoryDetails(with: reposUrl)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension DetailsViewController: DetailsViewDelegate {
    public func didTapCell(url: String) {
        coordinator?.navigate(to: .detailsWebView(url))
    }

    public func displayError(message: String) {
        self.showToast(message: message)
    }
}
