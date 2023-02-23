//
//  EventViewCellTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 22/02/23.
//

import XCTest
@testable import LBGAssignment

class EventViewCellTests: XCTestCase {

    var  tableView : UITableView!
    override func setUpWithError() throws {
        tableView = UITableView()
        tableView.register(UINib(nibName: EventViewCell.identifier, bundle: nil), forCellReuseIdentifier: EventViewCell.identifier)
    }

    func testForEventViewCellLoadAndConfigur() {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventViewCell.identifier, for: IndexPath(item: 0, section: 0)) as? EventViewCell
        XCTAssert(cell != nil)
        let event = Event.getSingleEventWithDummyData()!
        cell?.configure(event)
    }

}
