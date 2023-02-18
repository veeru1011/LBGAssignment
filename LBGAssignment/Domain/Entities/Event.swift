//
//  Event.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation

struct Events {
    let list:[Event]?
}

struct Event {
    let type: String?
    let title:String?
    let id:Int?
    let datetime:String?
    let venue:Venue?
    let performers:[Performer]?
}

struct Venue {
    let state: String?
    let name: String?
    let displayLocation:String?
}

struct Performer  {
    let image: String?
}
