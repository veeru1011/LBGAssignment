//
//  EventViewCell.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit
import Combine

final class EventViewCell: UITableViewCell {
    
    private var cancellables = Set<AnyCancellable>()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak private var mainContainer: UIView!
    @IBOutlet weak private var eventImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var venueLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    
    private var viewModel: EventViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // add shadow on cell
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.23
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowColor = UIColor.black.cgColor
        
        mainContainer.layer.cornerRadius = 8
        mainContainer.layer.masksToBounds = true
        
        eventImageView.layer.cornerRadius = 8
        eventImageView.clipsToBounds = true
        eventImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ event: Event) {
        self.viewModel = EventViewCellViewModel(event)
        self.eventImageView.image = nil
        titleLabel.text = viewModel?.getEventTitle()
        venueLabel.text = viewModel?.getVenueLocation()
        timeLabel.text = viewModel?.getEventTiming()
        self.bindViewModel()
        viewModel?.fetchCellImage()
    }
    
    private func bindViewModel() {
        viewModel?.$cellImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: eventImageView)
            .store(in: &cancellables)
    }
}
