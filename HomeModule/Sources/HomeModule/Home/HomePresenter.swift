import Domain
import Foundation

public protocol HomeDisplayLogic: AnyObject {
    func displayRepositories(_ viewModel: [HomeModel])
    func displayStartAnimation()
    func displayStopAnimation()
    func displayError(message: String)
}

public final class HomePresenter: HomeDisplayLogic {
    weak var view: HomeViewProtocol?
    
    public func displayRepositories(_ viewModel: [HomeModel]) {
        view?.configure(with: viewModel)
    }
    
    public func displayStartAnimation() {
        view?.startAnimation()
    }
    
    public func displayStopAnimation() {
        view?.stopAnimation()
    }
    
    public func displayError(message: String) {
        view?.displayError(message: message)
    }
}
