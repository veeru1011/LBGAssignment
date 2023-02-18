//
//  EventViewCellViewModel.swift
//  LBGAssignment
//
//  Created by mac on 19/02/23.
//

import UIKit

class EventViewCellViewModel {
    
    func loadImage(for imageURL: URL) async throws -> UIImage {
        return try await ImageLoader.shared.loadImage(for: imageURL)
    }
}
