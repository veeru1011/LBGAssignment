//
//  Event+Mock.swift
//  LBGAssignmentTests
//
//  Created by mac on 18/02/23.
//

import Foundation
@testable import LBGAssignment

extension Events {
    static func getDummy() -> Self? {
        let stringData = "{\"events\":[{\"type\":\"Type1\",\"title\":\"title 1\", \"datetime_utc\": \"2023-02-19T02:59:00\" , \"venue\":null,\"performers\":null}, {\"type\":\"Type2\",\"title\": \"title 2\" ,\"datetime_utc\": \"2023-02-19T02:59:00\" , \"venue\":null,\"performers\":null}]}"
        let data = stringData.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let userDecoded = try decoder.decode(Events.self, from: data)
            return userDecoded
        }
        catch {
            return nil
        }
    }
}

extension Event {
    static func getDummy(_ id : Int) -> Self? {
        let stringData = "{\"type\":\"Type\(id)\",\"title\":\"title \(id)\",\"datetime_utc\":\"\(Date().currentTimeInUTC())\", \"venue\":null,\"performers\":null}"
        let data = stringData.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let userDecoded = try decoder.decode(Event.self, from: data)
            return userDecoded
        }
        catch {
            return nil
        }
    }
    
    static func getSingleEventWithDummyData()-> Self? {
        let stringData = "{\"type\":\"concert\",\"title\":\"Zoolu 29 - 2 Day Pass featuring DEADMAU5 and SLANDER (18+)\", \"datetime_utc\":\"2023-02-19T02:59:00\", \"venue\":{\"state\":\"LA\",\"name\":\"The Metropolitan\", \"display_location\":\"New Orleans, LA\"},  \"performers\":[{\"image\":\"https://seatgeek.com/images/performers-landscape/deadmau5-69ff71/569/huge.jpg\"}]}"
        let data = stringData.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let userDecoded = try decoder.decode(Event.self, from: data)
            return userDecoded
        }
        catch {
            return nil
        }
    }
}
