//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 17.12.2023.
//

protocol MovieQuizViewControllerProtocol: AnyObject {
    func showLoadingState()
    func hideLoadingState()
    func showStartState(_ viewModel: QuizStepViewModel)
    func showQuestion(_ viewModel: QuizStepViewModel)
    func showAnswerResult(_ viewModel: QuizAnswerViewModel)
    func showGameResults(_ viewModel: QuizResultsViewModel)
    func showError(_ viewModel: QuizErrorViewModel)
}
