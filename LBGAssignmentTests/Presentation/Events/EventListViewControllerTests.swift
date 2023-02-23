//
//  EventListViewControllerTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 22/02/23.
//

import XCTest
@testable import LBGAssignment

class EventListViewControllerTests: XCTestCase {
    
    
    private var eventListVC: EventListViewController!
    
    // MARK: - Mock Repositories
    func makeEventsRepositoryMorkWithNoData() -> EventsRepository {
        let error = DataTransferError.networkFailure(NetworkError.notConnected)
        let networkService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: nil, error: error))
        let dataTransferService = DefaultDataTransferService(with: networkService)
        return EventsRepositoryService(dataTransferService: dataTransferService)
    }
    
    func makeEventsRepositoryMorkWithData() -> EventsRepository {
        let data = DummyDataHelper.dataFrom(resource: "DummyJson.json")
        let networkService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: data, error: nil))
        let dataTransferService = DefaultDataTransferService(with: networkService)
        return EventsRepositoryService(dataTransferService: dataTransferService)
    }
    
    override func setUp() {
        super.setUp()
        eventListVC = EventListViewController.instantiate(storyboard: .main) as? EventListViewController
        eventListVC.viewModel = EventListViewModel(repositoryService: makeEventsRepositoryMorkWithData())
        eventListVC.loadViewIfNeeded()
    }

    func testToLoadEventViewList() throws {
        let expectation = self.expectation(description: "list view loaded ")
        XCTAssert(eventListVC != nil)
        XCTAssertEqual(eventListVC.isViewLoaded, true)
        expectation.fulfill()
        wait(for: [expectation], timeout: 20)
    }
    
    func testToLoadEvenetViewControllerWithoutData() throws {
        let expectation = self.expectation(description: "no view loaded ")
        let noEventVC = EventListViewController.instantiate(storyboard: .main) as? EventListViewController
        noEventVC?.viewModel = EventListViewModel(repositoryService: makeEventsRepositoryMorkWithNoData())
        noEventVC?.loadViewIfNeeded()
        XCTAssert(eventListVC != nil)
        XCTAssertEqual(noEventVC?.isViewLoaded, true)
        expectation.fulfill()
        waitForExpectations(timeout: 50, handler: nil)
    }
}
