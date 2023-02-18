//
//  EventDetailViewController.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

class EventDetailViewController: UIViewController {

    ///class function to get EventDetailViewController object from main Storyboard
    
    static func loadVC(with viewModel: EventDetailViewModel, coodinator: Coordinator) -> EventDetailViewController {
        let vc = EventDetailViewController.instantiate(storyboard: .main) as! EventDetailViewController
        vc.viewModel = viewModel
        vc.coordinator = coodinator
        return vc
    }
        
    //MARK: IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    /// Set event model for display data in this detailview
    var viewModel: EventDetailViewModel?
    
    ///Coordinator
    var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        setupUI()
    }
    
    /** set up UI and display data for event*/
    func setupUI() {
        if let event = viewModel?.event {
            self.titleLabel.text = event.title
            self.venueLabel.text = event.venue?.displayLocation
            timeLabel.text = event.getEventTiming()
            self.setUpEventImage()
        }
    }
    
    private func setUpEventImage() {
        guard let imageURL = viewModel?.event.eventImageURL() else { return }
        Task {
            do {
                self.eventImageView.image = try await self.viewModel?.loadImage(for: imageURL)
            } catch {
                self.eventImageView.image = UIImage(named: "ProductPlaceholder")
            }
        }
    }
}
