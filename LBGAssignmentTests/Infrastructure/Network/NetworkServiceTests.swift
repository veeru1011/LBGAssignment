//
//  NetworkServiceTests.swift
//  LBGAssignmentTests
//
//  Created by mac on 18/02/23.
//

import XCTest
@testable import LBGAssignment

class NetworkServiceTests: XCTestCase {
    
    private struct EndpointMock: URLCompatible {
        var path: String
        public func getUrlRequest() throws -> URLRequest {
            let url = URL(string: path)
            let request = URLRequest(url: url!)
            return request
        }
    }
    
    private enum NetworkErrorMock: Error {
        case someError
    }
    func testForCorrectDataResponse() throws {
        let expectation = self.expectation(description: "return correct data")
        let expectedResponseData = "Response".data(using: .utf8)!
        let mockService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: expectedResponseData, error: nil))
        
        mockService.request(endpoint: EndpointMock(path: "http://mock.test.com")) { result in
            guard let responseData = try? result.get() else {
                XCTFail("Should return proper response")
                return
            }
            XCTAssertEqual(responseData, expectedResponseData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForReturnErrorInResponse() throws {
        let expectation = self.expectation(description: "return error")
        let cancelledError = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
        
        let mockService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: nil, error: cancelledError))
        
        mockService.request(endpoint: EndpointMock(path: "http://mock.test.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.cancelled = error else {
                    XCTFail("NetworkError.cancelled not found")
                    return
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForResponseWhenErrorInStatusCode() throws {
        let expectation = self.expectation(description: "Return statusCode error")
        
        let response = HTTPURLResponse(url: URL(string: "testing")!,
                                       statusCode: 403,
                                       httpVersion: "1.0",
                                       headerFields: [:])
        
        let mockService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: response, data: nil, error: NetworkErrorMock.someError))
        
        mockService.request(endpoint: EndpointMock(path: "http://mock.test.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case NetworkError.error(let statusCode, _) = error {
                    XCTAssertEqual(statusCode, 403)
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_whenhasStatusCodeUsedWithWrongError_shouldReturnFalse() {
        //when
        let sut = NetworkError.notConnected
        //then
        XCTAssertFalse(sut.hasStatusCode(200))
    }
    
    func test_whenhasStatusCodeUsed_shouldReturnCorrectStatusCode_() {
        //when
        let sut = NetworkError.error(statusCode: 400, data: nil)
        //then
        XCTAssertTrue(sut.hasStatusCode(400))
        XCTAssertFalse(sut.hasStatusCode(399))
        XCTAssertFalse(sut.hasStatusCode(401))
    }
    
    func test_forErrorCode404() {
        let sut = NetworkError.error(statusCode: 404, data: nil)
        XCTAssertTrue(sut.isNotFoundError)
    }
    
    func testForReturnErrorInNotConneted() {
        let expectation = self.expectation(description: "return error")
        let notConnectedError = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        let mockService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: nil, error: notConnectedError))
        
        mockService.request(endpoint: EndpointMock(path: "http://mock.test.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.notConnected = error else {
                    XCTFail("NetworkError.notConnected not found")
                    return
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForReturnErrorGenricError() {
        let expectation = self.expectation(description: "return error")
        let timeOut = NSError(domain: "network", code: NSURLErrorTimedOut, userInfo: nil)
        
        let mockService = DefaultNetworkService(sessionManager: NetworkSessionManagerMock(response: nil, data: nil, error: timeOut))
        
        mockService.request(endpoint: EndpointMock(path: "http://mock.test.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.generic( _) = error else {
                    XCTFail("NetworkError.generic not found")
                    return
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
