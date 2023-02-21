//
//  EventViewCellViewModel.swift
//  LBGAssignment
//
//  Created by mac on 19/02/23.
//

import UIKit
import Combine

class EventViewCellViewModel {
    var event: Event
    var eventUrlString : String
    @Published var cellImage: UIImage? = nil
    
    init(_ event: Event) {
        self.event = event
        self.eventUrlString = event.eventImageURL()?.absoluteString ?? ""
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
    
    func fetchCellImage() {
        if let imageURL = event.eventImageURL() {
            ImageLoader.shared.loadImage(for: imageURL) { [weak self] result in
                guard let self = self else { return }
                guard self.eventUrlString == imageURL.absoluteString else { return }
                if case let .success(data) = result, let rawData = data {
                    self.cellImage = UIImage(data: rawData)
                }
                else {
                    self.cellImage = UIImage(named: "placeholder")
                }
            }
        }
        else {
            self.cellImage = UIImage(named: "placeholder")
        }
    }
    
}
