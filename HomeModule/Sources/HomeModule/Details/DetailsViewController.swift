import UIKit
import Utils

public final class DetailsViewController: UIViewController, ViewController {
    public weak var coordinator: Utils.Coordinator?
    private let reposUrl: String
    private let repositoryName: String
    
    public init(
        reposUrl: String,
        repositoryName: String
    ) {
        self.reposUrl = reposUrl
        self.repositoryName = repositoryName
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .blue
        self.title = repositoryName
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}
