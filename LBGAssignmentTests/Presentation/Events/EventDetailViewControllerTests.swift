//
//  EventDetailViewControllerTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 22/02/23.
//

import XCTest
@testable import LBGAssignment

class EventDetailViewControllerTests: XCTestCase {

    var coordinator : AppCoordinator!
    var nvc : UINavigationController!
    override func setUpWithError() throws {
        coordinator = AppCoordinator()
        nvc = UINavigationController(rootViewController: UIViewController())
    }
    
    func testForLoadingDetailVC() throws {
        let event = Event.getSingleEventWithDummyData()!
        coordinator.navigateToEventDetails(event)
    }
    
    func testForLoadingDetailVCAlone() throws {
        let expectation = self.expectation(description: "list view loaded ")
        let event = Event.getSingleEventWithDummyData()!
        let detailVC = NavigationCoordinator.eventDetail(event).getViewController(coordinator)
        nvc.pushViewController(detailVC, animated: false)
        detailVC.loadViewIfNeeded()
        XCTAssertEqual(nvc.viewControllers.count, 2)
        XCTAssertEqual(detailVC.isViewLoaded, true)
        expectation.fulfill()
        waitForExpectations(timeout: 20, handler: nil)
    }

}
