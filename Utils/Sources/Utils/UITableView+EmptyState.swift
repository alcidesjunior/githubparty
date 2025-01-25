import UIKit

public extension UITableView {
    func setEmptyState(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let emptyStateView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
            
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.font = .systemFont(ofSize: 18, weight: .medium)
            messageLabel.textColor = .gray
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyStateView.addSubview(messageLabel)
            
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor),
                messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: emptyStateView.leadingAnchor, constant: 16),
                messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: emptyStateView.trailingAnchor, constant: -16)
            ])
            
            self.backgroundView = emptyStateView
        }
    }

    func removeEmptyState() {
        backgroundView = nil
    }
}
