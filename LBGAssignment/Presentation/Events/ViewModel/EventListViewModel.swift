//
//  EventListViewModel.swift
//  LBGAssignment
//
//  Created by mac on 16/02/23.
//

import Foundation
import Combine

protocol EventListViewModelAction {
    func getEvents()
    func refresh()
    func numberOfRowsInSection() -> Int
    func getItemAtIndex(_ index:Int) -> Event?
}

final class EventListViewModel {

    private let repositoryService: EventsRepository
    @Published var events: [Event] = []
    @Published var error: String? = nil
    @Published var isLoading : Bool = false
    let screenTitle = "Events"
    
    // MARK: - Init

    init(repositoryService: EventsRepository) {
        self.repositoryService = repositoryService
    }

    // MARK: - Private

    private func appendPage(_ events: [Event]) {
        self.events.append(contentsOf: events)
    }

    private func resetEvents() {
        events.removeAll()
    }
}

extension EventListViewModel : EventListViewModelAction {
    func getEvents() {
        self.isLoading = true
        repositoryService.fetchEvents { result in
            switch result {
            case .success(let events):
                self.appendPage(events.list ?? [])
            case .failure(let error):
                self.handle(error: error)
            }
            self.isLoading = false
        }
    }
    
    func refresh() {
        self.resetEvents()
        self.getEvents()
    }
    
    func numberOfRowsInSection() -> Int {
        return events.count
    }
    
    func getItemAtIndex(_ index:Int) -> Event?  {
        return events.count > index ? events[index] : nil
    }
    
    private func handle(error: Error) {
        if case DataTransferError.networkFailure(let networkError) = error {
            if case NetworkError.notConnected = networkError {
                self.error = "Network connection issue"
            }
            else {
                self.error = "Something went wrong"
            }
        }
        else {
            self.error = "Failed loading events"
        }
        
    }
}
