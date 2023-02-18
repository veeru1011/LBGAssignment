//
//  DefaultEventsRepository.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation
import Combine


final class DefaultEventsRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultEventsRepository : EventsRepository {
    func fetchEvents(completion: @escaping (Result<Events, Error>) -> Void) {
        let getEvent = APIEndpoints.getEvents()
        self.dataTransferService.request(with: getEvent) { result in
            switch result {
            case .success(let responseDTO):
                let response : Events = responseDTO.toDomain()
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
