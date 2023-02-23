//
//  EndPoint.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import Foundation
public enum HttpMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
}
public class Endpoint<R>: ResponseRequestable {
    public typealias Response = R
    
    public let path: String
    public let method: HttpMethod
    public let dataDecoder: DataDecoder
    
    init(path: String,method: HttpMethod, decoder: DataDecoder = JSONDataDecoder()) {
        self.path = path
        self.dataDecoder = decoder
        self.method = method
    }
}

public protocol URLCompatible {
    var path: String { get }
    var method: HttpMethod { get }
    func getUrlRequest() throws -> URLRequest
}

public protocol ResponseRequestable: URLCompatible {
    associatedtype Response
    var dataDecoder: DataDecoder { get }
}

extension URLCompatible {
    
    public func getUrlRequest() throws -> URLRequest {
        var baseURL = URL(string: APIConstants.apiURL)!
        if let pathUrl = URL(string: self.path), pathUrl.host != nil {
            baseURL = pathUrl
        }
        else {
            baseURL.appendPathComponent(self.path)
        }
        var components = URLComponents(string: baseURL.absoluteString)
        components?.queryItems = [URLQueryItem]()
        components?.queryItems?.append(contentsOf: [
            URLQueryItem(name: "client_id", value: APIConstants.clientID)])
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = method.rawValue
        return request
    }
}
