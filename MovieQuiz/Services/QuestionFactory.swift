//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 13.11.2023.
//

import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    weak var delegate: QuestionFactoryDelegate?
    
    private lazy var questions: [QuizQuestion] = {
        loadQuestions()
    }()
    
    func requestNextQuestion() {
        guard let index = (0..<questions.count).randomElement() else {
            delegate?.didReceiveNextQuestion(nil)
            return
        }
        
        let delayInSeconds: TimeInterval = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            guard let self else { return }
            
            self.delegate?.didReceiveNextQuestion(self.questions[safe: index])
        }
    }
}

private extension QuestionFactory {
    func loadQuestions() -> [QuizQuestion] {
        [
            QuizQuestion(
                imageName: "The Godfather",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "The Dark Knight",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "Kill Bill",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "The Avengers",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "Deadpool",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "The Green Knight",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "Old",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            ),
            QuizQuestion(
                imageName: "The Ice Age Adventures of Buck Wild",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            ),
            QuizQuestion(
                imageName: "Tesla",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            ),
            QuizQuestion(
                imageName: "Vivarium",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            )
        ]
    }
}
