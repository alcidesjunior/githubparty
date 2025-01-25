import Domain
import Foundation
import UIKit
import Utils

public protocol HomeViewCellProtocol: UITableViewCell {
    func configure(with viewModel: HomeModel)
}

public final class HomeViewCell: UITableViewCell {
    private lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textColor = .blue
        return label
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var forkIcon: UIImageView = {
        let icon = UIImageView()
        if #available(iOS 13.0, *) {
            icon.image = UIImage(systemName: "arrow.triangle.branch")
        }
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .orange
        return icon
    }()
    
    private lazy var forkCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .orange
        return label
    }()
    
    private lazy var forkStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var starIcon: UIImageView = {
        let icon = UIImageView()
        if #available(iOS 13.0, *) {
            icon.image = UIImage(systemName: "star.fill")
        }
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .orange
        return icon
    }()
    
    private lazy var starCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .orange
        return label
    }()
    
    private lazy var starStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension HomeViewCell: HomeViewCellProtocol {
    public func configure(with viewModel: HomeModel) {
        repositoryNameLabel.text = viewModel.repositoryName
        repositoryDescriptionLabel.text = viewModel.description
        profileImageView.loadImage(from: viewModel.profileImageUrl)
        userNameLabel.text = viewModel.profileName
        forkCountLabel.text = String(viewModel.forkCount)
        starCountLabel.text = String(viewModel.starCount)
    }
}

extension HomeViewCell: ViewCode {
    public func setupComponent() {
        contentView.addSubview(container)
        container.addSubview(mainStackView)
        [repositoryNameLabel, repositoryDescriptionLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        container.addSubview(profileStackView)
        [profileImageView, userNameLabel].forEach {
            profileStackView.addArrangedSubview($0)
        }
        
        [forkIcon, forkCountLabel].forEach {
            forkStackView.addArrangedSubview($0)
        }
        
        [starIcon, starCountLabel].forEach {
            starStackView.addArrangedSubview($0)
        }
        
        container.addSubview(footerStackView)
        [forkStackView, starStackView].forEach {
            footerStackView.addArrangedSubview($0)
        }
    }
    
    public func setupConstrain() {
        constrainContainer()
        constrainMainStack()
        constrainProfileStack()
        constrainProfileImage()
        constrainFooterStackView()
        constrainForkIcon()
        constrainStarIcon()
    }
    
    private func constrainProfileImage() {
        NSLayoutConstraint.activate(
            [
                profileImageView.heightAnchor.constraint(equalToConstant: 40),
                profileImageView.widthAnchor.constraint(equalToConstant: 40)
            ]
        )
    }
    
    private func constrainForkIcon() {
        NSLayoutConstraint.activate(
            [
                forkIcon.heightAnchor.constraint(equalToConstant: 20),
                forkIcon.widthAnchor.constraint(equalToConstant: 20)
            ]
        )
    }
    
    private func constrainStarIcon() {
        NSLayoutConstraint.activate(
            [
                starIcon.heightAnchor.constraint(equalToConstant: 20),
                starIcon.widthAnchor.constraint(equalToConstant: 20)
            ]
        )
    }
    
    private func constrainContainer() {
        NSLayoutConstraint.activate(
            [
                container.topAnchor.constraint(equalTo: topAnchor),
                container.leadingAnchor.constraint(equalTo: leadingAnchor),
                container.trailingAnchor.constraint(equalTo: trailingAnchor),
                container.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
    
    private func constrainMainStack() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
                mainStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16)
            ]
        )
    }
    
    private func constrainProfileStack() {
        NSLayoutConstraint.activate(
            [
                profileStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
                profileStackView.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 8),
                profileStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
                profileStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 90)
            ]
        )
    }
            
    private func constrainFooterStackView() {
        NSLayoutConstraint.activate(
            [
                footerStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
                footerStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
                footerStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
            ]
        )
    }
}
