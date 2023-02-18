//
//  String.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation

extension Date {
    func currentTimeInUTC() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: Date())
    }
}
