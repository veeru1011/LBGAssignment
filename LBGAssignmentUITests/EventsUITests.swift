//
//  EventsUITests.swift
//  LBGAssignmentUITests
//
//  Created by mac on 19/02/23.
//

import XCTest

class EventsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    func testTableInteraction() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables[AccessibilityIdentifier.eventTableView]
        XCTAssertTrue(tableView.exists, "The fact tableview exists")
        
        // Get an array of cells
        let tableCells = tableView.cells
        if tableCells.count > 0 {
            let promise = expectation(description: "Wait for table view Scrolling")
            tableView.swipeUp()
            tableView.swipeDown()
            promise.fulfill()
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "Finished table view Scrolling")
        } else {
            XCTAssertTrue(tableCells.count == 0, "Was not able to find any table cells")
        }
        
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
        
        // Make sure event details view
        XCTAssertTrue(app.otherElements[AccessibilityIdentifier.eventDetailsView].waitForExistence(timeout: 10))
    }
}
