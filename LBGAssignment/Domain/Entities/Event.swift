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

struct Event : Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    let type: String?
    let title:String?
    let id:Int?
    let datetime:String?
    let venue:Venue?
    let performers:[Performer]?
    
    func getEventTiming() -> String? {
        datetime?.longFormatDateText()
    }
    
    func eventImageURL() -> URL?  {
        guard let performers = performers,
              let first = performers.first,
              let image = first.image,
              let imgURL = URL(string: image) else { return nil }
        return imgURL
    }
}

struct Venue {
    let state: String?
    let name: String?
    let displayLocation:String?
}

struct Performer  {
    let image: String?
}
