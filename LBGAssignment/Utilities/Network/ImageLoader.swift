//
//  ImageLoader.swift
//  LBGAssignment
//
//  Created by mac on 19/02/23.
//

import Foundation
import UIKit

enum APIError: Error {
    case badRequest
    case serverError
    case dataError
    case unknown
    case noNetwork
}

// MARK: - HTTP Response Status Codes
enum HttpStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case internalServerError = 500
}


class ImageLoader {
    static var shared = ImageLoader()
    private var cache = NSCache<NSString, UIImage>()
    
    func loadImage(for url: URL) async throws -> UIImage {
        if let cachedImage = self.getCachedImage(for: url) {
            return cachedImage
        }
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HttpStatusCode.success.rawValue else {
            throw APIError.badRequest
        }
        guard let image = UIImage(data: data) else {
            throw APIError.dataError
        }
        self.cacheImage(image, for: url)
        return image
    }
    
    
    func cacheImage(_ image: UIImage, for url: URL) {
        self.cache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
    
    func getCachedImage(for url: URL) -> UIImage? {
        self.cache.object(forKey: NSString(string: url.absoluteString))
    }
}
