//
//  EventsRepositoryService.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation
import Combine


final class EventsRepositoryService {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension EventsRepositoryService : EventsRepository {
    func fetchEvents(completion: @escaping (Result<Events, Error>) -> Void) {
        let getEvent = APIEndpoints.getEvents()
        self.dataTransferService.request(with: getEvent) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
