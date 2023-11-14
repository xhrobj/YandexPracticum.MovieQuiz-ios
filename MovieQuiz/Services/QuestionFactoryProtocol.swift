//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 14.11.2023.
//

protocol QuestionFactoryProtocol {
    func requestNextQuestion() -> QuizQuestion?
}
