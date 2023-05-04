//
//  MockedNetworkingServiceTests.swift
//  VendorsAppTests
//
//  Created by Артур Заволович on 04.05.2023.
//

import Foundation
import XCTest
import Combine

@testable import VendorsApp

class MockedNetworkingServiceTests: XCTestCase {

    // MARK: - Properties
    
    var networkingService: NetworkingService!
    var subscriptions: Set<AnyCancellable>!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        networkingService = MockedNetworkingService()
        subscriptions = []
    }
    
    override func tearDown() {
        networkingService = nil
        subscriptions = nil
        super.tearDown()
    }
    
    // MARK: - Test cases
    
    func testFetchDataSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Data fetching failed")
        let url = Bundle.main.url(forResource: "vendors", withExtension: "json")!
        
        // When
        networkingService.fetchData(for: VendorsResponse.self, from: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        XCTFail("Unexpected error: \(error.localizedDescription)")
                    case .finished:
                        expectation.fulfill()
                }
            }, receiveValue: { data in
                // Then
                XCTAssertNotNil(data)
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchDataFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Not a valid JSON")
        let expectedError = DecodingError.dataCorrupted(.init(codingPath: [],
                                                              debugDescription: "The given data was not valid JSON."))
        let url = Bundle.main.url(forResource: "mock", withExtension: "json")!
        
        // When
        networkingService.fetchData(for: VendorsResponse.self, from: url)
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTFail("Expected failure, but got success")
                    case let .failure(error):
                        XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                        expectation.fulfill()
                }
            } receiveValue: { data in
                XCTFail("Expected failure, but got success")
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchDataDecodingErrorTypeMismatch() {
        // Given
        let expectation = XCTestExpectation(description: "Type mismatch")
        let expectedError = DecodingError.typeMismatch([Vendor].self, .init(codingPath: [], debugDescription: "Expected to decode Array<Any> but found a dictionary instead."))
        let url = Bundle.main.url(forResource: "vendors", withExtension: "json")!
        
        // When
        networkingService.fetchData(for: [Vendor].self, from: url)
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTFail("Expected failure, but got success")
                    case let .failure(error):
                        XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                        expectation.fulfill()
                }
            } receiveValue: { data in
                XCTFail("Expected failure, but got success")
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchDataDecodingErrorKeyNotFound() {
        // Given
        let expectation = XCTestExpectation(description: "Data decoding failed")
        let expectedError = DecodingError.keyNotFound(Vendor.CodingKeys.id, .init(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"id\", intValue: nil) (\"id\")."))
        let url = Bundle.main.url(forResource: "vendors", withExtension: "json")!
        
        // When
        networkingService.fetchData(for: Vendor.self, from: url)
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTFail("Expected failure, but got success")
                    case let .failure(error):
                        XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                        expectation.fulfill()
                }
            } receiveValue: { data in
                XCTFail("Expected failure, but got success")
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
