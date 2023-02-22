//
//  DefaultEventsRepositoryTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 19/02/23.
//

import XCTest
@testable import LBGAssignment

class DefaultEventsRepositoryTests: XCTestCase {
    
    class DefaultEventsRepositoryMock : EventsRepository {
        private let dataTransferService: DataTransferService
        
        init(dataTransferService: DataTransferService) {
            self.dataTransferService = dataTransferService
        }
        
        func fetchEvents(completion: @escaping (Result<Events, Error>) -> Void) {
            let endPoint = Endpoint<EventsResponseDTO>(path: "http://mock.endpoint.com")
            self.dataTransferService.request(with: endPoint) { result in
                switch result {
                case .success(let responseDTO):
                    let response : Events = responseDTO.toDomain()
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func testForDummyDataresponse() throws {
        let expectation = self.expectation(description: "response in not proper format ")
        let data = DummyDataHelper.dataFrom(resource: "DummyJson.json")
        let networkService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: data, error: nil))
        let dts = DefaultDataTransferService(with: networkService)
        let eventRepo = DefaultEventsRepositoryMock(dataTransferService: dts)
        var eventList : [Event] = []
        eventRepo.fetchEvents { result in
            eventList = (try? result.get().list) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(eventList.count, 2)
    }
}
