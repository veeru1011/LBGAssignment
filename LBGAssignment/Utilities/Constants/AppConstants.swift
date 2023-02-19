//
//  AppConstants.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation

// MARK: - Date formater
public enum DateFormatType : String {
    case serverUTCFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case displayFormat = "EEE, dd MMM yyyy h:mm a"
}

// MARK:  AlertView Variables
public enum AlertViewVariables: String {
    case errorTitle = "Error"
    case cancel = "cancel"
    case ok = "ok"
}

public struct AccessibilityIdentifier {
    static let eventTableView = "eventTableView"
    static let eventDetailsView = "eventDetailsView"
}
