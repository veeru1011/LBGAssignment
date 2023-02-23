//
//  NetworkSessionManagerMock.swift
//  LBGAssignmentTests
//
//  Created by mac on 21/02/23.
//

import Foundation
@testable import LBGAssignment

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) {
        completion(data, response, error)
    }
}
