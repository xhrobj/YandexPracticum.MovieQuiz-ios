//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Mikhail Eliseev on 08.12.2023.
//

import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        let expected = 2
        let array = [1, expected, 3]
        
        let actual = array[safe: 1]
        
        XCTAssertEqual(expected, actual)
    }
    
    func testGetValueOutRange() throws {
        let array = [1, 2, 3]
        
        let result = array[safe: 3]
        
        XCTAssertNil(result)
    }
}
