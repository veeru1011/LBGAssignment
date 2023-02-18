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
    @Published var error: String? = nil
    @Published var isLoading : Bool = false

    // MARK: - OUTPUT
    var isEmpty: Bool { return events.isEmpty }
    
    func numberOfRowsInSection() -> Int {
        return events.count
    }
    
    func getItemAtIndex(_ index:Int) -> Event?  {
        if events.count > index {
            return events[index]
        }
        else {
            return nil
        }
    }

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
        self.isLoading = true
        getEventUseCase.execute { result in
            switch result {
            case .success(let page):
                self.appendPage(page.list ?? [])
            case .failure(let error):
                self.error = error.localizedDescription
            }
            self.isLoading = false
        }
    }
}

// MARK: - Private

private extension Array where Element == Events {
    var events: [Event] { flatMap { $0.list ?? [] } }
}
