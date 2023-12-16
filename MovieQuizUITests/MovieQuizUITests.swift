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
        sleep(2)
        
        let startPoster = app.images[Identifiers.imagePoster.rawValue]
        let startPosterData = startPoster.screenshot().pngRepresentation
        let startQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label
        
        app.buttons[Identifiers.buttonYes.rawValue].tap()
        
        sleep(2)
        
        let nextPoster = app.images[Identifiers.imagePoster.rawValue]
        let nextPosterData = nextPoster.screenshot().pngRepresentation
        let nextQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label

        XCTAssertNotEqual(startPosterData, nextPosterData)
        XCTAssertEqual(startQuestionIndexLabel, "1/10")
        XCTAssertEqual(nextQuestionIndexLabel, "2/10")
    }
    
    func testNoButton() {
        sleep(2)
        
        let startPoster = app.images[Identifiers.imagePoster.rawValue]
        let startPosterData = startPoster.screenshot().pngRepresentation
        let startQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label
        
        app.buttons[Identifiers.buttonNo.rawValue].tap()
        
        sleep(2)
        
        let nextPoster = app.images[Identifiers.imagePoster.rawValue]
        let nextPosterData = nextPoster.screenshot().pngRepresentation
        let nextQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label

        XCTAssertNotEqual(startPosterData, nextPosterData)
        XCTAssertEqual(startQuestionIndexLabel, "1/10")
        XCTAssertEqual(nextQuestionIndexLabel, "2/10")
    }
    
    func testAlert() {
        sleep(2)
        
        let startPoster = app.images[Identifiers.imagePoster.rawValue]
        let startPosterData = startPoster.screenshot().pngRepresentation
        let startQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label
        
        app.buttons[Identifiers.buttonNo.rawValue].tap()
        
        sleep(2)
        
        let nextPoster = app.images[Identifiers.imagePoster.rawValue]
        let nextPosterData = nextPoster.screenshot().pngRepresentation
        let nextQuestionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label

        XCTAssertNotEqual(startPosterData, nextPosterData)
        XCTAssertEqual(startQuestionIndexLabel, "1/10")
        XCTAssertEqual(nextQuestionIndexLabel, "2/10")
    }
    
    func testGameFinish() {
        sleep(2)
        
        for _ in 1...10 {
            app.buttons[Identifiers.buttonNo.rawValue].tap()
            sleep(2)
        }

        let alert = app.alerts[Identifiers.alertRoundResults.rawValue]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть ещё раз")
    }

    func testAlertDismiss() {
        sleep(2)
        
        for _ in 1...10 {
            app.buttons[Identifiers.buttonNo.rawValue].tap()
            sleep(2)
        }
        
        let alert = app.alerts[Identifiers.alertRoundResults.rawValue]
        alert.buttons.firstMatch.tap()
        
        sleep(2)
        
        let questionIndexLabel = app.staticTexts[Identifiers.labelQuestionIndex.rawValue].label
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(questionIndexLabel == "1/10")
    }
}

private extension MovieQuizUITests {
    enum Identifiers: String {
        case labelQuestionIndex = "QuestionIndex"
        case imagePoster = "Poster"
        case buttonYes = "Yes"
        case buttonNo = "No"
        case alertRoundResults = "RoundResults"
    }
}
