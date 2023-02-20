//
//  EventViewCellViewModelTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 19/02/23.
//

import XCTest
@testable import LBGAssignment

class EventViewCellViewModelTests: XCTestCase {
    
    func testForLoadingImage() async {
        
        let event = Event.getSingleEventWithDummyData()
        let viewModel = EventViewCellViewModel()
        
        guard let imageURL = event.eventImageURL() else { return }
        do {
            let image = try await viewModel.loadImage(for: imageURL)
            XCTAssertNotNil(image)
        } catch {
            XCTAssertNotNil(error, "error while loading image")
        }
    }
    
}
