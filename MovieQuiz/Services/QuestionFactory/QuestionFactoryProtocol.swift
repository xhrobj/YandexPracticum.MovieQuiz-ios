//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 14.11.2023.
//

protocol QuestionFactoryProtocol: AnyObject {
    var delegate: QuestionFactoryDelegate? { get set }
    
    func loadQuestionsList()
    func requestNextQuestion()
}
