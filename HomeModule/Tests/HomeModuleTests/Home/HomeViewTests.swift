import Domain
import XCTest

@testable import HomeModule

final class HomeViewTests: XCTestCase {
    private let delegateSpy = HomeViewDelegateSpy()
    private lazy var sut: HomeView = {
        let home = HomeView()
        home.delegate = delegateSpy
        return home
    }()
    
    func test_displayError_whenCalled() {
        sut.displayError(message: "message")
        
        XCTAssertTrue(delegateSpy.displayErrorCalled)
        XCTAssertEqual(delegateSpy.displayErrorPassed, "message")
    }
    
    func test_didTap_whenCalled_shouldCallDidTapCell() {
        let item: HomeModel = .fixture()
        let viewModel: [HomeModel] = [item]
        sut.configure(with: viewModel)
        
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(delegateSpy.didTapCellCalled)
    }
    
    func test_willdisplay_whenIndexPathEqualToDataSourceCountMinusFive_shouldCallLoadMoreData() {
        let item: HomeModel = .fixture()
        let viewModel: [HomeModel] = [item, item, item, item, item, item, item, item, item, item, item]
        sut.configure(with: viewModel)
        
        sut.tableView(UITableView(), willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 6, section: 0))
        XCTAssertTrue(delegateSpy.loadMoreDataCalled)
    }
    
    func test_willdisplay_whenIndexPathNotEqualToDataSourceCountMinusFive_shouldNotCallLoadMoreData() {
        let item: HomeModel = .fixture()
        let viewModel: [HomeModel] = [item, item, item, item, item, item, item, item, item, item, item]
        sut.configure(with: viewModel)
        
        sut.tableView(UITableView(), willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 4, section: 0))
        XCTAssertFalse(delegateSpy.loadMoreDataCalled)
    }
}
