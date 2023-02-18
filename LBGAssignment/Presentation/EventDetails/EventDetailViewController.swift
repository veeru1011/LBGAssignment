//
//  EventDetailViewController.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

class EventDetailViewController: UIViewController {

    ///class function to get EventDetailViewController object from main Storyboard
    
    static func loadVC(with event: Event, coodinator: Coordinator) -> EventDetailViewController {
        let vc = EventDetailViewController.instantiate(storyboard: .main) as! EventDetailViewController
        vc.event = event
        vc.coordinator = coodinator
        return vc
    }
    
    class func laodViewController() -> EventDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        return vc as! EventDetailViewController
    }
        
    //MARK: IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    /// Set event model for display data in this detailview
    var event: Event?
    
    ///Coordinator
    var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        setupUI()
    }
    
    /** set up UI and display data for event*/
    func setupUI() {
        if let event = event {
            self.titleLabel.text = event.title
            self.venueLabel.text = event.venue?.displayLocation
            timeLabel.text = event.getEventTiming()
            //self.eventImageView.sd_setImage(with: URL(string: event.getImageURLString()), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
    }

}
