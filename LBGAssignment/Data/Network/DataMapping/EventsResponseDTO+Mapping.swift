//
//  EventsResponseDTO+Mapping.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation

// MARK: - Data Transfer Object

struct EventsResponseDTO: Decodable {
    let list:[EventDTO]?
    
    /// Coding Keys for Events
    private enum CodingKeys: String, CodingKey {
        case list = "events"
    }
}

extension EventsResponseDTO {
    struct EventDTO: Decodable {
        let type: String?
        let title:String?
        let id:Int?
        let datetime:String?
        let venue:VenueDTO?
        let performers:[PerformerDTO]?
        
        /// Coding Keys for Event
        private enum CodingKeys: String, CodingKey {
            case type = "type"
            case title = "title"
            case id = "id"
            case datetime = "datetime_utc"
            case venue = "venue"
            case performers = "performers"
        }
    }
}

extension EventsResponseDTO.EventDTO {
    struct VenueDTO:Codable {
        let state: String?
        let name: String?
        let displayLocation:String?
        
        /// Coding Keys for Venue
        enum CodingKeys: String, CodingKey {
            case state = "state" // Raw value for enum case must be a literal
            case name = "name"
            case displayLocation = "display_location"
        }
    }
    
    struct PerformerDTO :Codable {
        let image: String?
    }
}
// MARK: - Mappings to Domain

extension EventsResponseDTO {
    func toDomain() -> Events {
        return Events(list: list?.compactMap({ $0.toDomain() }))
    }
}

extension EventsResponseDTO.EventDTO {
    func toDomain() -> Event {
        return .init(type: type,
                     title: title,
                     id: id,
                     datetime: datetime,
                     venue: venue?.toDomain(),
                     performers: performers?.compactMap({ $0.toDomain() }))
    }
}

extension EventsResponseDTO.EventDTO.VenueDTO {
    func toDomain() -> Venue {
        return .init(state: state, name: name, displayLocation: displayLocation)
    }
}

extension EventsResponseDTO.EventDTO.PerformerDTO {
    func toDomain() -> Performer {
        return .init(image: image)
    }
}
