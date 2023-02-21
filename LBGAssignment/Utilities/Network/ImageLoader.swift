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
    private var networkSessionManager : NetworkSessionManager
    
    private init() {
        self.networkSessionManager = DefaultNetworkSessionManager()
    }
    
    func updateNetworkSessionManager(_ sessionManager : NetworkSessionManager) {
        self.networkSessionManager = sessionManager
    }
    
    func loadImage(for url:URL,completion: @escaping (Result<Data?, Error>) -> Void) {
        if let cachedImage = self.getCachedImage(for: url) {
            completion(.success(cachedImage.pngData()))
        }
        let request = URLRequest(url: url)
        self.networkSessionManager.request(request) { data, response, error in
            if let requestError = error {
                completion(.failure(requestError))
            } else {
                guard let rawData = data , let image = UIImage(data: rawData) else {
                    completion(.failure(NSError(domain: "", code: NSURLErrorDataNotAllowed, userInfo: nil)))
                    return
                }
                self.cacheImage(image, for: url)
                completion(.success(data))
            }
        }
    }
    
    
    func cacheImage(_ image: UIImage, for url: URL) {
        self.cache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
    
    func getCachedImage(for url: URL) -> UIImage? {
        self.cache.object(forKey: NSString(string: url.absoluteString))
    }
}
