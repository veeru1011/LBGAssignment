//
//  EventDetailViewModel.swift
//  LBGAssignment
//
//  Created by mac on 19/02/23.
//

import UIKit

class EventDetailViewModel {
    var event: Event
    init(_ event: Event) {
        self.event = event
    }
    func loadEventImage() async throws -> UIImage {
        if let imageURL = event.eventImageURL() {
            return try await ImageLoader.shared.loadImage(for: imageURL)
        }
        else {
            return UIImage(named: "placeholder") ?? UIImage()
        }
    }
    
    func getEventTitle() -> String? {
        event.title
    }
    func getVenueLocation() -> String? {
        event.venue?.displayLocation
    }
    
    func getEventTiming() -> String? {
        event.getEventTiming()
    }
}
