//
//  EventDetailViewController.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit
import Combine

final class EventDetailViewController: BaseViewController {
    
    private var cancellables = Set<AnyCancellable>()
    //MARK: IBOutlet Properties
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var venueLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var eventImageView: UIImageView!
    
    /// Set event model for display data in this detailview
    var viewModel: EventDetailViewModel?
    
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
            self.bindViewModel()
            self.viewModel?.fetchImage()
            
        }
        view.accessibilityIdentifier = AccessibilityIdentifier.eventDetailsView
    }
    private func bindViewModel() {
        viewModel?.$cellImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: eventImageView)
            .store(in: &cancellables)
    }
}
