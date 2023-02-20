//
//  Coordinator.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func setUpInitialNavigationController() -> UINavigationController
    func navigateToEventDetails(_ event: Event)
}

final class AppCoordinator: Coordinator {
        
    var navigationController: UINavigationController?
    
    init() {
        setupAppearance()
    }

    func setUpInitialNavigationController() -> UINavigationController {
        let vc = EventListViewController.loadVC(with: EventListViewModel(getEventUseCase: makeEventUseCase()), coodinator: self)
        navigationController = UINavigationController(rootViewController: vc)
        return navigationController!
    }
    
    func navigateToEventDetails(_ event: Event) {
        let eventDetailViewModel = EventDetailViewModel(event)
        let vc = EventDetailViewController.loadVC(with: eventDetailViewModel, coodinator: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    /// setUp App
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(red: 37/255.0, green: 37/255.0, blue: 37.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

extension AppCoordinator {
    // MARK: - Use Cases
    func makeEventUseCase() -> GetEventUseCase {
        return DefaultGetEventUseCase(eventRepository: makeEventsRepository())
    }
    
    // MARK: - Repositories
    func makeEventsRepository() -> EventsRepository {
        let sessionManager = DefaultNetworkSessionManager()
        let netWorkService = DefaultNetworkService(sessionManager: sessionManager)
        let dataTransferService = DefaultDataTransferService(with: netWorkService)
        return DefaultEventsRepository(dataTransferService: dataTransferService)
    }
}
