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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([EventDTO].self, forKey: .list)
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
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try? container.decode(String.self, forKey: .type)
            title = try? container.decode(String.self, forKey: .title)
            id = try? container.decode(Int.self, forKey: .id)
            datetime = try? container.decode(String.self, forKey: .datetime)
            venue = try? container.decode(VenueDTO.self, forKey: .venue)
            performers = try? container.decode([PerformerDTO].self, forKey: .performers)
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
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            state = try? container.decode(String.self, forKey: .state)
            name = try? container.decode(String.self, forKey: .name)
            displayLocation = try? container.decode(String.self, forKey: .displayLocation)
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
