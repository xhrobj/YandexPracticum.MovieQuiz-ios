//
//  IMDbQuestionFactory.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

final class IMDbQuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoadingProtocol
    
    weak var delegate: QuestionFactoryDelegate?
    
    private var indexSet = Set<Int>()
    private var questions: [QuizQuestion] = []
    
    init(moviesLoader: MoviesLoadingProtocol, delegate: QuestionFactoryDelegate) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func loadData() {
        moviesLoader.loadMovies { result in
            switch result {
            case .success:
                self.delegate?.didLoadDataFromServer()
            case .failure(let error):
                self.delegate?.didFailToLoadData(with: error)
            }
        }
    }
    
    func requestNextQuestion() {
        guard let index = fetchNextIndex() else {
            delegate?.didReceiveNextQuestion(nil)
            
            return
        }

        self.delegate?.didReceiveNextQuestion(self.questions[safe: index])
    }
}

// MARK: - Private methods

private extension IMDbQuestionFactory {
    func resetIndexSet() {
        indexSet = Set(0..<questions.count)
    }
    
    func fetchNextIndex() -> Int? {
        if indexSet.isEmpty {
            resetIndexSet()
        }
        
        guard let index = indexSet.randomElement() else {
            return nil
        }
        
        indexSet.remove(index)
        
        return index
    }
}
