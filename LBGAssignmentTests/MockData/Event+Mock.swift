//
//  Event+Mock.swift
//  LBGAssignmentTests
//
//  Created by mac on 18/02/23.
//

import Foundation
@testable import LBGAssignment

extension Event {
    static func getDummy(_ id : Int) -> Self {
        Event(type: "Type\(id)", title: "title \(id)", id: id, datetime: Date().currentTimeInUTC(), venue: nil, performers: nil)
    }
    
    static func getSingleEventWithDummyData()-> Self {
        let performers = [Performer(image: "https://seatgeek.com/images/performers-landscape/deadmau5-69ff71/569/huge.jpg")]
        let venue = Venue(state: "LA", name: "The Metropolitan", displayLocation: "New Orleans, LA")
        return Event(type: "concert", title: "Zoolu 29 - 2 Day Pass featuring DEADMAU5 and SLANDER (18+)", id: 5889017, datetime: "2023-02-19T02:59:00", venue: venue, performers: performers)
    }
}
