//
//  NavigationCoordinator.swift
//  LBGAssignment
//
//  Created by mac on 21/02/23.
//

import UIKit

enum NavigationCoordinator {
        
    case eventList
    case eventDetail(_ event: Event)
    
    func getViewController(_ coordinator :Coordinator) -> UIViewController {
        switch self {
        case .eventList:
            let eventListVC = EventListViewController.instantiate(storyboard: .main) as! EventListViewController
            eventListVC.coordinator = coordinator
            eventListVC.viewModel = EventListViewModel(repositoryService: makeEventsRepository())
            return eventListVC
        case .eventDetail(let event):
            let eventDetailVC = EventDetailViewController.instantiate(storyboard: .main) as! EventDetailViewController
            eventDetailVC.coordinator = coordinator
            eventDetailVC.viewModel = EventDetailViewModel(event)
            return  eventDetailVC
        }
    }
}

extension NavigationCoordinator {
    
    // MARK: - Repositories
    func makeEventsRepository() -> EventsRepository {
        let sessionManager = DefaultNetworkSessionManager()
        let netWorkService = DefaultNetworkService(sessionManager: sessionManager)
        let dataTransferService = DefaultDataTransferService(with: netWorkService)
        return EventsRepositoryService(dataTransferService: dataTransferService)
    }
}
