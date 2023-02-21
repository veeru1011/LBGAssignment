//
//  BaseViewController.swift
//  LBGAssignment
//
//  Created by mac on 21/02/23.
//

import UIKit

protocol baseVC {
    func loadViewController()
}
class BaseViewController: UIViewController , baseVC {
    func loadViewController() { }
    
    
    // MARK: - Properties
    var activityIndicator: UIActivityIndicatorView?
    var coordinator: Coordinator?
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Activity Indicator
    func startIndicator() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 40,height: 40))
            activityIndicator?.center = self.view.center
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.style = .large
            view.addSubview(activityIndicator!)
        }
        activityIndicator?.startAnimating()
    }
    
    func stopIndicator() {
        self.activityIndicator?.stopAnimating()
    }
}
