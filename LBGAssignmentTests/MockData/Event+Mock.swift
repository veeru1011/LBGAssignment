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
}
