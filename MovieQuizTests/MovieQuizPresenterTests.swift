//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by Mikhail Eliseev on 17.12.2023.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func showLoadingState() {}
    func hideLoadingState() {}
    func showStartState(_ viewModel: MovieQuiz.QuizStepViewModel) {}
    func showQuestion(_ viewModel: MovieQuiz.QuizStepViewModel) {}
    func showAnswerResult(_ viewModel: MovieQuiz.QuizAnswerViewModel) {}
    func showGameResults(_ viewModel: MovieQuiz.QuizResultsViewModel) {}
    func showError(_ viewModel: MovieQuiz.QuizErrorViewModel) {}
}

final class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(imageData: emptyData, text: "Question Text", correctAnswer: .yes)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "0/10")
    }
}
