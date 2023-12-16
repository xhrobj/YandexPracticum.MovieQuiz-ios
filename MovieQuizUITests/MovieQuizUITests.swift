//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Mikhail Eliseev on 15.12.2023.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    func testYesButton() {
        sleep(3)
        
        let startPoster = app.images[Identifiers.imagePoster.rawValue]
        let startPosterData = startPoster.screenshot().pngRepresentation
        let startQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label
        
        app.buttons[Identifiers.buttonYes.rawValue].tap()
        
        sleep(5)
        
        let nextPoster = app.images[Identifiers.imagePoster.rawValue]
        let nextPosterData = nextPoster.screenshot().pngRepresentation
        let nextQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label

        XCTAssertNotEqual(startPosterData, nextPosterData)
        XCTAssertEqual(startQuestionIndexLabel, "1/10")
        XCTAssertEqual(nextQuestionIndexLabel, "2/10")
    }
}

private extension MovieQuizUITests {
    enum Identifiers: String {
        case labelQuestionIndex = "QuestionIndex"
        case imagePoster = "Poster"
        case buttonYes = "Yes"
    }
}
