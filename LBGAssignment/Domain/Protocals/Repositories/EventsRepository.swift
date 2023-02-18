//
//  EventsRepository.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation
protocol EventsRepository {
    func fetchEvents(completion: @escaping (Result<Events, Error>) -> Void)
}
