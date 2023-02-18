//
//  UIStoryboard.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}
extension UIStoryboard {
    class var main: UIStoryboard {
        return UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
    }
}
