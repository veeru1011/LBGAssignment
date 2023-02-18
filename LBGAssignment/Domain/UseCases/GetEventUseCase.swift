//
//  GetEventUseCase.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation

protocol GetEventUseCase {
    func execute(completion: @escaping (Result<Events, Error>) -> Void)
}

final class DefaultGetEventUseCase: GetEventUseCase {

    private let eventRepository: EventsRepository

    init(eventRepository: EventsRepository) {
        self.eventRepository = eventRepository
    }

    func execute(completion: @escaping (Result<Events, Error>) -> Void) {
        self.eventRepository.fetchEvents { result in
            completion(result)
        }
    }
}
