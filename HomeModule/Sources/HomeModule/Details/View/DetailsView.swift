import Data
import Domain
import UIKit
import Utils

public protocol DetailsViewProtocol: UIView {
    var delegate: DetailsViewDelegate? { get set }
    
    func configure(with dataSource: [HomeDetailsModel])
    func startAnimation()
    func stopAnimation()
    func displayError(message: String)
    func displayEmptyState()
}

public protocol DetailsViewDelegate: AnyObject {
    func didTapCell(url: String)
    func displayError(message: String)
}

public final class DetailsView: UIView, DetailsViewProtocol {
    public weak var delegate: DetailsViewDelegate?
    
    private var dataSource: [HomeDetailsModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.detailsTableView.reloadData()
            }
        }
    }

    private lazy var detailsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(DetailsViewCell.self, forCellReuseIdentifier: "detailsViewCell")
        tv.rowHeight = UITableView.automaticDimension
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    public init() {
        super.init(frame: .zero)
        setup()
        detailsTableView.removeEmptyState()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    public func configure(with dataSource: [HomeDetailsModel]) {
        self.dataSource = dataSource
    }
    
    public func startAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    public func stopAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    public func displayError(message: String) {
        delegate?.displayError(message: message)
    }
    
    public func displayEmptyState() {
        detailsTableView.setEmptyState("Nada por aqui...")
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailsViewCell") as? DetailsViewCellProtocol, dataSource.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
        
        let currentDataSourceRow = dataSource[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: currentDataSourceRow)
        cell.setNeedsLayout()
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataSource.indices.contains(indexPath.row) else { return }
        let url = dataSource[indexPath.row].htmlUrl
        delegate?.didTapCell(url: url)
    }
}

extension DetailsView: ViewCode {
    public func setupComponent() {
        addSubview(detailsTableView)
        addSubview(activityIndicator)
    }
    
    public func setupConstrain() {
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: topAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
