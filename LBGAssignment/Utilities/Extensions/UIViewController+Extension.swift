//
//  UIViewController+Extension.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
    
    class func instantiate<T: UIViewController>(storyboard: UIStoryboard) -> T? {
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
    public func showErrorText(_ error: Error) {
        showErrorText(error.localizedDescription)
    }
    
    public func showErrorText(_ error: String) {
        showAlert(errorMessage: error, okTitle: AlertViewVariables.cancel.rawValue)
    }
        
    func showAlert(errorMessage: String, okTitle: String = AlertViewVariables.ok.rawValue,
                   okButtonAction: (() -> Void)? = nil) {
        
        // Create new Alert
        let alertVC = UIAlertController(title: AlertViewVariables.errorTitle.rawValue, message: errorMessage, preferredStyle: .alert)
        // Create OK button with action handler
        let okayAction = UIAlertAction(title: okTitle, style: .default, handler: { _ in
            okButtonAction?()
        })
        alertVC.addAction(okayAction)

        // Present Alert to
        self.present(alertVC, animated: true, completion: nil)
    }
}
