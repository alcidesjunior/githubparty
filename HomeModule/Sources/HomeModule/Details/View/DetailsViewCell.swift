import Domain
import UIKit
import Utils

public protocol DetailsViewCellProtocol: UITableViewCell {
    func configure(with viewModel: HomeDetailsModel)
}

public final class DetailsViewCell: UITableViewCell {
    private lazy var pullTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: DS.Font.size20)
        return label
    }()
    
    private lazy var pullBodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textAlignment = .justified
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: DS.Font.size14)
        return label
    }()
    
    private lazy var pullDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: DS.Font.size10)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = DS.Spacing.spacing8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [pullTitleLabel, profileHorizontalStackView, pullBodyLabel].forEach {
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
        label.font = UIFont.boldSystemFont(ofSize: DS.Font.size10)
        label.textColor = .blue
        return label
    }()
    
    private lazy var profileHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = DS.Spacing.spacing4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        [profileImageView, profileVerticalStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var profileVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [userNameLabel, pullDateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension DetailsViewCell: ViewCode {
    public func setupComponent() {
        contentView.addSubview(container)
        container.addSubview(mainStackView)
    }
    
    public func setupConstrain() {
        constrainContainer()
        constrainProfileImage()
        constrainMainStack()
    }
    
    private func constrainContainer() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func constrainProfileImage() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: DS.Dimension.size20),
            profileImageView.widthAnchor.constraint(equalToConstant: DS.Dimension.size20),
        ])
    }
    
    private func constrainMainStack() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: DS.Spacing.spacing16),
            mainStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: DS.Spacing.spacing16),
            mainStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -DS.Spacing.spacing16),
            mainStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -DS.Spacing.spacing16)
        ])
    }
}

extension DetailsViewCell: DetailsViewCellProtocol {
    public func configure(with viewModel: HomeDetailsModel) {
        pullTitleLabel.text = viewModel.title
        pullBodyLabel.text = viewModel.body
        pullDateLabel.text = viewModel.createdAt
        guard let url = URL(string: viewModel.avatarUrl) else { return }
        profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: DS.Other.defaultImage))
        userNameLabel.text = viewModel.login
    }
}
