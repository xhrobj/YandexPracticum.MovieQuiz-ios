//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 14.11.2023.
//

protocol QuestionFactoryDelegate: AnyObject {
    func didLoadQuestions()
    func didReceiveNextQuestion(_ question: QuizQuestion)
    func didFailToLoadQuestionsList(with error: Error)
    func didFailToReceiveNextQuestion(with error: Error)
}
