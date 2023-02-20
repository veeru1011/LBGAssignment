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
        Events(list: [Event.getDummy(1),Event.getDummy(2),Event.getDummy(3)])
    }()
    
    class GetEventUseCaseMock: GetEventUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var events = Events(list: nil)
        func execute(completion: @escaping (Result<Events, Error>) -> Void) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(events))
            }
            expectation?.fulfill()
        }
    }
    
    func testEventsLoadwithThreeEvents() throws {
        
        let getEventUseCaseMock = GetEventUseCaseMock()
        getEventUseCaseMock.expectation = self.expectation(description: "contains three events")
        getEventUseCaseMock.events = events
        let viewModel = EventListViewModel(getEventUseCase: getEventUseCaseMock)
        viewModel.getEvents()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.events.count, 3)
        XCTAssertNotNil(viewModel.events[0].getEventTiming)
    }
    
    func testForSomeError() {
        let getEventUseCaseMock = GetEventUseCaseMock()
        getEventUseCaseMock.expectation = self.expectation(description: "some errors")
        getEventUseCaseMock.error = GetEventUseCaseError.someError
        let viewModel = EventListViewModel(getEventUseCase: getEventUseCaseMock)
        viewModel.getEvents()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testEventsRefresh() throws {
        
        let getEventUseCaseMock = GetEventUseCaseMock()
        let expectation = self.expectation(description: "contains three events after refresh")
        expectation.expectedFulfillmentCount = 2
        getEventUseCaseMock.expectation = expectation
        getEventUseCaseMock.events = events
        let viewModel = EventListViewModel(getEventUseCase: getEventUseCaseMock)
        viewModel.getEvents()
        viewModel.refresh()
        XCTAssertEqual(viewModel.events.count, 3)
        XCTAssertNotNil(viewModel.events[0].getEventTiming)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testForNotNetworkError() throws {
        let getEventUseCaseMock = GetEventUseCaseMock()
        getEventUseCaseMock.expectation = self.expectation(description: "notConnected errors")
        getEventUseCaseMock.error = DataTransferError.networkFailure(NetworkError.notConnected)
        let viewModel = EventListViewModel(getEventUseCase: getEventUseCaseMock)
        viewModel.getEvents()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testForGenricNetworkError() throws {
        let getEventUseCaseMock = GetEventUseCaseMock()
        getEventUseCaseMock.expectation = self.expectation(description: "generic network errors")
        let error = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
        getEventUseCaseMock.error = DataTransferError.networkFailure(NetworkError.generic(error))
        let viewModel = EventListViewModel(getEventUseCase: getEventUseCaseMock)
        viewModel.getEvents()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
}

