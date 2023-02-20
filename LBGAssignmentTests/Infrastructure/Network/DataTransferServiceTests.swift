//
//  DataTransferServiceTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 18/02/23.
//

import XCTest
@testable import LBGAssignment

private struct DummyModel: Decodable {
    let name: String
}

class DataTransferServiceTests: XCTestCase {
    
    func testResponseDataDecodableToDummyObject() {
        
        let expectation = self.expectation(description: "response in DummyModel ")
        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        let networkService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        let dts = DefaultDataTransferService(with: networkService)
        
        dts.request(with: Endpoint<DummyModel>(path: "http://mock.endpoint.com")) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForInValidResponse_DataNoDecodableToDummyObject() {
        
        let expectation = self.expectation(description: "response in not proper format ")
        let responseData = #"{"age": 20}"#.data(using: .utf8)
        let networkService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        let dts = DefaultDataTransferService(with: networkService)
        
        dts.request(with: Endpoint<DummyModel>(path: "http://mock.endpoint.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForNoDataInResponse() {
        
        let expectation = self.expectation(description: "no data error")
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let networkService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: response, data: nil, error: nil))
        let dts = DefaultDataTransferService(with: networkService)
        
        dts.request(with: Endpoint<DummyModel>(path: "http://mock.endpoint.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case DataTransferError.noResponse = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
}
