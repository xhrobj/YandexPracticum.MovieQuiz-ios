//
//  IMDbMoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by Mikhail Eliseev on 08.12.2023.
//

import XCTest
@testable import MovieQuiz

class IMDbMoviesLoaderTests: XCTestCase {
    func testSuccessLoading() {
        let stubNetworkClient = StubNetworkClient(emulateError: false)
        let loader = IMDbMoviesLoader(networkClient: stubNetworkClient)
        
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.count, 2)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure")
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFailureLoading() {
        let stubNetworkClient = StubNetworkClient(emulateError: true)
        let loader = IMDbMoviesLoader(networkClient: stubNetworkClient)
        
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected success")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
}
