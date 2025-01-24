import UIKit

public extension UIImageView {
    func loadImage(from urlString: String) {
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "person.fill")
            tintColor = .black
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

