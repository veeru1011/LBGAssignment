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
        if let dt = datetime {
            return dt.longFormatDateText()
        }
        else {
            return nil
        }
    }
    
    func eventImageURL() -> URL?  {
        if let performers = performers,
            let first = performers.first,
            let image = first.image,
            let imgURL = URL(string: image) {
            return imgURL
        }
        else {
            return nil
        }
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
