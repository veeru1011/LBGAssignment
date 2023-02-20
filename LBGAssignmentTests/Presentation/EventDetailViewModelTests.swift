//
//  EventDetailViewModelTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 19/02/23.
//

import XCTest
@testable import LBGAssignment

class EventDetailViewModelTests: XCTestCase {
    
    func testDetailEventPageImageLoader() async throws {
        let event = Event.getSingleEventWithDummyData()
        let viewModel = EventDetailViewModel(event)
        do {
            let image = try await viewModel.loadEventImage()
            XCTAssertNotNil(image)
        } catch {
            XCTAssertNotNil(error, "error while loading image")
        }
    }
    
    func testForImageLoadingFailure() async throws {
        let event = Event.getDummy(1)
        let viewModel = EventDetailViewModel(event)
        do {
            let image = try await viewModel.loadEventImage()
            XCTAssertEqual(image, UIImage(named: "placeholder") ?? UIImage())
        } catch {
            XCTAssertNotNil(error, "No error while downloading image")
            XCTFail("Failed to download image")
        }
    }
    
    func testForEventDisplayDescription() throws {
        let event = Event.getSingleEventWithDummyData()
        let viewModel = EventDetailViewModel(event)
        XCTAssertNotNil(viewModel.getEventTitle())
        XCTAssertNotNil(viewModel.getVenueLocation())
        XCTAssertNotNil(viewModel.getEventTiming())
        
    }
    
}
