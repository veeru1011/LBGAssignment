//
//  GetEventUseCase.swift
//  LBGAssignmentTests
//
//  Created by mac on 18/02/23.
//

import XCTest
@testable import LBGAssignment

class GetEventUseCaseTests: XCTestCase {
    
    static let events : Events = {
        Events(list: [Event.getDummy(1),Event.getDummy(2),Event.getDummy(3)])
    }()
    
    class EventsRepositoryMock : EventsRepository {
        var events: Events = GetEventUseCaseTests.events
        func fetchEvents(completion: @escaping (Result<Events, Error>) -> Void) {
            completion(.success(events))
        }
        
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetEventUseCase() throws {
        // given
        let expectation = self.expectation(description: "promise")
        expectation.expectedFulfillmentCount = 2
        let eventsRepositoryMock = EventsRepositoryMock()
        let useCase = DefaultGetEventUseCase(eventRepository: eventsRepositoryMock)

        useCase.execute { _ in
            expectation.fulfill()
        }
        var eventList : [Event] = []
        eventsRepositoryMock.fetchEvents { result in
            eventList = (try? result.get().list) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(eventList.contains(Event.getDummy(1)))
    }

}
