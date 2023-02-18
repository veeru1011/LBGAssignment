//
//  EventListViewModel.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation
import Combine

final class EventListViewModel {

    private let getEventUseCase: GetEventUseCase
    @Published var events: [Event] = []
    @Published var error: String = ""

    // MARK: - OUTPUT
    var isEmpty: Bool { return events.isEmpty }

    // MARK: - Init

    init(getEventUseCase: GetEventUseCase) {
        self.getEventUseCase = getEventUseCase
    }

    // MARK: - Private

    private func appendPage(_ events: [Event]) {
        self.events.append(contentsOf: events)
    }

    private func resetPages() {
        events.removeAll()
    }

    func getEvents() {
        getEventUseCase.execute { result in
            switch result {
            case .success(let page):
                self.appendPage(page.list ?? [])
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}

// MARK: - Private

private extension Array where Element == Events {
    var events: [Event] { flatMap { $0.list ?? [] } }
}
