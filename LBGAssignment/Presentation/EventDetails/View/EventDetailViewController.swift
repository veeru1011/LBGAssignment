//
//  EventDetailViewController.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

final class EventDetailViewController: BaseViewController {
    
    ///class function to get EventDetailViewController object from main Storyboard
    
    static func loadVC(with viewModel: EventDetailViewModel) -> EventDetailViewController {
        let vc = EventDetailViewController.instantiate(storyboard: .main) as! EventDetailViewController
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: IBOutlet Properties
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var venueLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var eventImageView: UIImageView!
    
    /// Set event model for display data in this detailview
    private var viewModel: EventDetailViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        setupUI()
    }
    
    /** set up UI and display data for event*/
    private func setupUI() {
        if let viewModel = viewModel {
            self.titleLabel.text = viewModel.getEventTitle()
            self.venueLabel.text = viewModel.getVenueLocation()
            timeLabel.text = viewModel.getEventTiming()
            self.setUpEventImage()
        }
        view.accessibilityIdentifier = AccessibilityIdentifier.eventDetailsView
    }
    
    private func setUpEventImage() {
        Task {
            do {
                self.eventImageView.image =  try await self.viewModel?.loadEventImage()
            } catch {
                self.eventImageView.image = UIImage(named: "placeholder")
            }
        }
    }
}
