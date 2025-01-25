import Domain
import XCTest
import TestUtils
import UIKit

@testable import HomeModule

final class DetailsViewTests: XCTestCase {
    private let delegateSpy = DetailsViewDelegateSpy()
    private lazy var sut: DetailsView = {
        let view = DetailsView()
        view.delegate = delegateSpy
        return view
    }()
    
    func test_displayError_whenCalled_shouldDelegateDisplayError() {
        sut.displayError(message: "error")
        
        XCTAssertTrue(delegateSpy.displayErrorCalled)
        XCTAssertEqual(delegateSpy.displayErrorPassed, "error")
    }
    
    func test_didTap_whenCalled_shouldCallDidTapCell() {
        let item: HomeDetailsModel = .fixture(htmlUrl: "url")
        let viewModel: [HomeDetailsModel] = [item]
        sut.configure(with: viewModel)
        
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(delegateSpy.didTapCellCalled)
        XCTAssertEqual(delegateSpy.didTapCellPassed, "url")
    }
    
    func test_didTap_whenNotContainsItemOnDateSource_shouldNotCallDidTapCell() {
        let item: HomeDetailsModel = .fixture(htmlUrl: "url")
        let viewModel: [HomeDetailsModel] = [item]
        sut.configure(with: viewModel)
        
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 3, section: 0))
        XCTAssertFalse(delegateSpy.didTapCellCalled)
    }
}
