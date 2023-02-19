//
//  String+Extension.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation

extension String {
    func longFormatDateText() -> String {
        var formattedDate = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatType.serverUTCFormat.rawValue
        if let date = dateFormatter.date(from: self) {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = DateFormatType.displayFormat.rawValue
            formattedDate =  dateFormatter1.string(from: date)
        }
        return formattedDate
    }
}
