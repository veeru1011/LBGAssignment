//
//  Event.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation

struct Events : Codable {
    let list:[Event]?
    
    /// Coding Key for Events
    private enum CodingKeys: String, CodingKey {
        case list = "events"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([Event].self, forKey: .list)
    }
}

struct Event : Codable {
    
    let type: String?
    let title:String?
    let id:Int?
    let datetime:String?
    let venue:Venue?
    let performers:[Performer]?
    
    /// Coding Keys for Event
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case id = "id"
        case datetime = "datetime_utc"
        case venue = "venue"
        case performers = "performers"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try? container.decode(String.self, forKey: .type)
        title = try? container.decode(String.self, forKey: .title)
        id = try? container.decode(Int.self, forKey: .id)
        datetime = try? container.decode(String.self, forKey: .datetime)
        venue = try? container.decode(Venue.self, forKey: .venue)
        performers = try? container.decode([Performer].self, forKey: .performers)
    }
    
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

struct Venue : Codable {
    let state: String?
    let name: String?
    let displayLocation:String?
    
    /// Coding Keys for Venue
    enum CodingKeys: String, CodingKey {
        case state = "state" // Raw value for enum case must be a literal
        case name = "name"
        case displayLocation = "display_location"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        state = try? container.decode(String.self, forKey: .state)
        name = try? container.decode(String.self, forKey: .name)
        displayLocation = try? container.decode(String.self, forKey: .displayLocation)
    }
}

struct Performer  : Codable {
    let image: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try? container.decode(String.self, forKey: .image)
    }
}
