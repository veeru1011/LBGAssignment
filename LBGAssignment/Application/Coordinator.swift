//
//  Coordinator.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation
import UIKit

protocol Coordinator {
    func setUpInitialNavigationController() -> UINavigationController
    func navigateToEventDetails(_ event: Event)
}

final class AppCoordinator: Coordinator {
    
    private var navigationController: UINavigationController?
    
    init() {
        setupAppearance()
    }
    
    func setUpInitialNavigationController() -> UINavigationController {
        let viewController = NavigationCoordinator.eventList.getViewController(self)
        navigationController = UINavigationController(rootViewController: viewController)
        return navigationController!
    }
    
    func navigateToEventDetails(_ event: Event) {
        let vc = NavigationCoordinator.eventDetail(event).getViewController(self)
        self.pushViewController(vc)
    }
    
    private func pushViewController(_ viewcontroller:UIViewController) {
        navigationController?.pushViewController(viewcontroller, animated: true)
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
