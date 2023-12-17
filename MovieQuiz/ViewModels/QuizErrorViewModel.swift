//
//  QuizErrorViewModel.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 17.12.2023.
//

struct QuizErrorViewModel {
    let accessibilityIdentifier: String?
    let message: String
    let retryAction: () -> Void
}
