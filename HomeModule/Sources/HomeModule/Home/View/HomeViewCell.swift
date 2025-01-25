import Domain
import Foundation
import UIKit
import Utils
import Kingfisher

public protocol HomeViewCellProtocol: UITableViewCell {
    func configure(with viewModel: HomeModel)
}

public final class HomeViewCell: UITableViewCell {
    private lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        [repositoryNameLabel, repositoryDescriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
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
        label.translatesAutoresizingMaskIntoConstraints = false
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
        [profileImageView, userNameLabel].forEach {
            stackView.addArrangedSubview($0)
        }
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        return label
    }()
    
    private lazy var forkStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        [forkIcon, forkCountLabel].forEach {
            stack.addArrangedSubview($0)
        }
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        return label
    }()
    
    private lazy var starStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        [starIcon, starCountLabel].forEach {
            stack.addArrangedSubview($0)
        }
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
        [forkStackView, starStackView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension HomeViewCell: HomeViewCellProtocol {
    public func configure(with viewModel: HomeModel) {
        repositoryNameLabel.text = viewModel.repositoryName
        repositoryDescriptionLabel.text = viewModel.description
        guard let url = URL(string: viewModel.profileImageUrl) else { return }
        profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.fill"))
        userNameLabel.text = viewModel.profileName
        forkCountLabel.text = String(viewModel.forkCount)
        starCountLabel.text = String(viewModel.starCount)
    }
}

extension HomeViewCell: ViewCode {
    public func setupComponent() {
        contentView.addSubview(container)
        container.addSubview(mainStackView)
        container.addSubview(profileStackView)
        container.addSubview(footerStackView)
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
    
    private func constrainContainer() {
        NSLayoutConstraint.activate(
            [
                container.topAnchor.constraint(equalTo: contentView.topAnchor),
                container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    private func constrainMainStack() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
                mainStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
                mainStackView.trailingAnchor.constraint(equalTo: profileStackView.leadingAnchor, constant: -8),
                mainStackView.bottomAnchor.constraint(equalTo: footerStackView.topAnchor, constant: -16)
            ]
        )
    }
    
    private func constrainProfileStack() {
        NSLayoutConstraint.activate(
            [
                profileStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
                profileStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
                profileStackView.widthAnchor.constraint(equalToConstant: 90)
            ]
        )
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

    private func constrainFooterStackView() {
        NSLayoutConstraint.activate(
            [
                footerStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
                footerStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
            ]
        )
    }
}
