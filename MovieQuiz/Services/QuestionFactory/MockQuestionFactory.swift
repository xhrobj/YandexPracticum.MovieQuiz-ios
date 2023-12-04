//
//  MockQuestionFactory.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 13.11.2023.
//

import UIKit

final class MockQuestionFactory: QuestionFactoryProtocol {
    weak var delegate: QuestionFactoryDelegate?
    
    private var questionsIndexSet = Set<Int>()
    private var questions: [QuizQuestion] = []
    
    func loadQuestionsList() {
        let delayInSeconds: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            guard let self else { return }
            
            questions = loadQuestions()
            delegate?.didLoadQuestions()
        }
    }
    
    func requestNextQuestion() {
        guard let nextQuestionsIndex = fetchNextQuestionsIndex(),
              let nextQuestion = questions[safe: nextQuestionsIndex]
        else {
            delegate?.didFailToReceiveNextQuestion(with: QuestionFactoryError.questionPreparationFailed)
            return
        }
        
        let delayInSeconds: TimeInterval = [0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0].randomElement() ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            guard let self else { return }
            
            delegate?.didReceiveNextQuestion(nextQuestion)
        }
    }
}

// MARK: - Private methods

private extension MockQuestionFactory {
    func resetQuestionsIndexSet() {
        questionsIndexSet = Set(0..<questions.count)
    }
    
    func fetchNextQuestionsIndex() -> Int? {
        if questionsIndexSet.isEmpty {
            resetQuestionsIndexSet()
        }
        
        guard let questionsIndex = questionsIndexSet.randomElement() else {
            return nil
        }
        
        questionsIndexSet.remove(questionsIndex)
        
        return questionsIndex
    }
}

private extension MockQuestionFactory {
    func loadQuestions() -> [QuizQuestion] {
        [
            QuizQuestion(
                imageData: data(fromImage: "The Godfather"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageData: data(fromImage: "The Dark Knight"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageData: data(fromImage: "Kill Bill"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageData: data(fromImage: "The Avengers"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageData: data(fromImage: "Deadpool"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageData: data(fromImage: "The Green Knight"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageData: data(fromImage: "Old"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            ),
            QuizQuestion(
                imageData: data(fromImage: "The Ice Age Adventures of Buck Wild"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            ),
            QuizQuestion(
                imageData: data(fromImage: "Tesla"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            ),
            QuizQuestion(
                imageData: data(fromImage: "Vivarium"),
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: .no
            )
        ]
    }
    
    func data(fromImage imageName: String) -> Data {
        (UIImage(named: imageName) ?? UIImage()).pngData() ?? Data()
    }
}
