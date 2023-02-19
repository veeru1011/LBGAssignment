//
//  UITableView.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit

public extension UITableView {
    func registerClass(_ myClass:AnyClass) {
        let bundle = Bundle(for: myClass)
        let className = NSStringFromClass(myClass).components(separatedBy: ".").last
        self.register(UINib(nibName: className!, bundle: bundle), forCellReuseIdentifier: className!)
    }
    
    func dequeue<T>(_ cellType:T.Type,indexPath:IndexPath) -> T where T:UITableViewCell {
        let className = NSStringFromClass(cellType).components(separatedBy: ".").last
        return self.dequeueReusableCell(withIdentifier: className!, for: indexPath) as! T
    }
}
