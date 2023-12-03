//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 14.11.2023.
//

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(_ question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
