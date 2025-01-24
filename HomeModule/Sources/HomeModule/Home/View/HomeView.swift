import Domain
import UIKit
import Utils

public protocol HomeViewProtocol: UIView {
    var delegate: HomeViewDelegate? { get set }
    func configure(with dataSource: [HomeModel])
    func startAnimation()
    func stopAnimation()
    func displayError(message: String)
}

public protocol HomeViewDelegate: AnyObject {
    func loadMoreData()
    func didTapCell(reposUrl: String)
    func displayError(message: String)
}

public final class HomeView: UIView, HomeViewProtocol {
    public weak var delegate: HomeViewDelegate?
    
    private var dataSource: [HomeModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.homeTableView.reloadData()
            }
        }
    }

    private lazy var homeTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(HomeViewCell.self, forCellReuseIdentifier: "homeViewCell")
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 200
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
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    public func configure(with dataSource: [HomeModel]) {
        self.dataSource.append(contentsOf: dataSource)
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
}

extension HomeView: ViewCode {
    public func setupComponent() {
        addSubview(homeTableView)
        addSubview(activityIndicator)
    }
    
    public func setupConstrain() {
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: self.topAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: homeTableView.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeViewCell") as? HomeViewCellProtocol, dataSource.indices.contains(indexPath.row) else {
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
        let reposUrl = dataSource[indexPath.row].reposUrl
        delegate?.didTapCell(reposUrl: reposUrl)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 5 {
            delegate?.loadMoreData()
        }
    }
}
