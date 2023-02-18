//
//  APIEndPoints.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation

struct APIEndpoints {
    static func getEvents() -> Endpoint<EventsResponseDTO> {
        return Endpoint(path: "events")
    }
}