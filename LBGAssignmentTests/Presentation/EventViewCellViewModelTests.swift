//
//  EventViewCellViewModelTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 19/02/23.
//

import XCTest
import Combine
@testable import LBGAssignment

class EventViewCellViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testForEventDisplayDescription() throws {
        let event = Event.getSingleEventWithDummyData()!
        let viewModel = EventViewCellViewModel(event)
        XCTAssertNotNil(viewModel.getEventTitle())
        XCTAssertNotNil(viewModel.getVenueLocation())
        XCTAssertNotNil(viewModel.getEventTiming())
    }
    
    func testForPlayerHolderImage_whenWrongImageData() throws {
        let expectation = self.expectation(description: "image data")
        expectation.expectedFulfillmentCount = 2
        let expectedImage = "image data".data(using: .utf8)!
        let manager = NetworkSessionManagerMock(response: nil, data: expectedImage, error: nil)
        ImageLoader.shared.updateNetworkSessionManager(manager)
        let event = Event.getDummy(1)!
        let viewModel = EventViewCellViewModel(event)
        
        var expectationCount = 0
        
        viewModel.$cellImage
            .receive(on: DispatchQueue.main)
            .sink { image in
                expectationCount += 1
                if expectationCount == 1 {
                    XCTAssertNil(image)
                }
                else {
                    XCTAssertEqual(image, UIImage(named: "placeholder"))
                }
                
                expectation.fulfill()
            }.store(in: &cancellables)
        
        viewModel.fetchCellImage()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.$cellImage)
    }
    
    func testForRealImageData() throws {
        let expectation = self.expectation(description: "image download success")
        expectation.expectedFulfillmentCount = 2
        let event = Event.getSingleEventWithDummyData()!
        let viewModel = EventViewCellViewModel(event)
        
        var expectationCount = 0
        
        viewModel.$cellImage
            .receive(on: DispatchQueue.main)
            .sink { image in
                expectationCount += 1
                if expectationCount == 1 {
                    XCTAssertNil(image)
                }
                else {
                    XCTAssertNotNil(image)
                }
                expectation.fulfill()
            }.store(in: &cancellables)
        
        viewModel.fetchCellImage()
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(viewModel.$cellImage)
    }
    
}
