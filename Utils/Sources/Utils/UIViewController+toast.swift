import UIKit

public extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.masksToBounds = true
        
        let padding: CGFloat = 16
        let maxWidth: CGFloat = self.view.frame.size.width - 40
        
        let textSize = message.boundingRect(
            with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: toastLabel.font as Any],
            context: nil
        ).size
        
        let toastWidth = min(maxWidth, textSize.width + padding * 2)
        let toastHeight = textSize.height + padding
        
        toastLabel.frame = CGRect(
            x: (self.view.frame.size.width - toastWidth) / 2,
            y: position == .bottom ? self.view.frame.size.height - toastHeight - 50 : 100,
            width: toastWidth,
            height: toastHeight
        )
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
    
    enum ToastPosition {
        case bottom
        case top
    }
}
