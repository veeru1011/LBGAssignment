//
//  EventViewCell.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

class EventViewCell: UITableViewCell {
    
    @IBOutlet private var mainContainer: UIView!
    @IBOutlet private var eventImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var venueLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    
    var event: Event? {
        didSet {
            self.titleLabel.text  = ""
            self.venueLabel.text  = ""
            self.timeLabel.text  = ""
            self.eventImageView.image = nil
            guard let e = event else { return }
            if let title = e.title {
                titleLabel.text = title
                venueLabel.text = e.venue?.displayLocation
                timeLabel.text = e.getEventTiming()
                //self.eventImageView.sd_setImage(with: URL(string: e.getImageURLString()), placeholderImage: #imageLiteral(resourceName: "placeholder"))
            }
        }
    }
    
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

        // Configure the view for the selected state
    }
    
}
