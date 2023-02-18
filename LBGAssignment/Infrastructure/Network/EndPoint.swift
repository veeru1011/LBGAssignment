//
//  EndPoint.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation

public class Endpoint<R>: ResponseRequestable {
    public typealias Response = R
    
    public let path: String
    public let dataDecoder: DataDecoder
    
    init(path: String, decoder: DataDecoder = JSONDataDecoder()) {
        self.path = path
        self.dataDecoder = decoder
    }
}

public protocol URLCompatible {
    var path: String { get }
    func getUrlRequest() throws -> URLRequest
}

public protocol ResponseRequestable: URLCompatible {
    associatedtype Response
    var dataDecoder: DataDecoder { get }
}

extension URLCompatible {
        
    public func getUrlRequest() throws -> URLRequest {
        var components = URLComponents(string: APIConstants.apiURL + self.path)
        components?.queryItems = [URLQueryItem]()
        components?.queryItems?.append(contentsOf: [
            URLQueryItem(name: "client_id", value: APIConstants.clientID)])
        let request = URLRequest(url: (components?.url)!)
        return request
    }
}
