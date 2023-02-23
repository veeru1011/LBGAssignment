//
//  EventListViewModelTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 18/02/23.
//

import XCTest
@testable import LBGAssignment

class EventListViewModelTests: XCTestCase {
    
    private enum GetEventUseCaseError: Error {
        case someError
    }
    
    let events : Events = {
        Events.getDummy()!
    }()
    
    class EventsRepositoryServiceMock : EventsRepository {
        var expectation: XCTestExpectation?
        var error: Error?
        var events : Events?
        
        func fetchEvents(completion: @escaping (Result<Events, Error>) -> Void) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(events!))
            }
            expectation?.fulfill()
        }
    }
    
    func testEventsLoadwithThreeEvents() throws {
        
        let repositoryServiceMock = EventsRepositoryServiceMock()
        repositoryServiceMock.expectation = self.expectation(description: "contains three events")
        repositoryServiceMock.events = events
        let viewModel = EventListViewModel(repositoryService: repositoryServiceMock)
        viewModel.getEvents()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.events.count, 2)
        XCTAssertNotNil(viewModel.events[0].getEventTiming)
    }
    
    func testForSomeError() {
        let repositoryServiceMock = EventsRepositoryServiceMock()
        repositoryServiceMock.expectation = self.expectation(description: "some errors")
        repositoryServiceMock.error = GetEventUseCaseError.someError
        let viewModel = EventListViewModel(repositoryService: repositoryServiceMock)
        viewModel.getEvents()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testEventsRefresh() throws {
        
        let repositoryServiceMock = EventsRepositoryServiceMock()
        let expectation = self.expectation(description: "contains three events after refresh")
        expectation.expectedFulfillmentCount = 2
        repositoryServiceMock.expectation = expectation
        repositoryServiceMock.events = events
        let viewModel = EventListViewModel(repositoryService: repositoryServiceMock)
        viewModel.getEvents()
        viewModel.refresh()
        XCTAssertEqual(viewModel.events.count, 2)
        XCTAssertNotNil(viewModel.getItemAtIndex(0)?.getEventTiming)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testForNotNetworkError() throws {
        let repositoryServiceMock = EventsRepositoryServiceMock()
        repositoryServiceMock.expectation = self.expectation(description: "notConnected errors")
        repositoryServiceMock.error = DataTransferError.networkFailure(NetworkError.notConnected)
        let viewModel = EventListViewModel(repositoryService: repositoryServiceMock)
        viewModel.getEvents()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testForGenricNetworkError() throws {
        let repositoryServiceMock = EventsRepositoryServiceMock()
        repositoryServiceMock.expectation = self.expectation(description: "generic network errors")
        let error = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
        repositoryServiceMock.error = DataTransferError.networkFailure(NetworkError.generic(error))
        let viewModel = EventListViewModel(repositoryService: repositoryServiceMock)
        viewModel.getEvents()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
}

