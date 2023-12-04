//
//  IMDbQuestionFactory.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

final class IMDbQuestionFactory: QuestionFactoryProtocol {
    private let randomRatingRange = 5...8
    private let moviesLoader: IMDbMoviesLoadingProtocol
    
    private var movies: [IMDbMovieDTO] = []
    
    weak var delegate: QuestionFactoryDelegate?

    init(moviesLoader: IMDbMoviesLoadingProtocol, delegate: QuestionFactoryDelegate) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func loadQuestionsList() {
        moviesLoader.loadMovies { result in
            switch result {
            case .success(let moviesList):
                self.movies = moviesList
                self.delegate?.didLoadQuestions()
            case .failure(let error):
                self.delegate?.didFailToLoadQuestionsList(with: error)
            }
        }
    }
    
    func requestNextQuestion() {
        guard !movies.isEmpty else {
            delegate?.didFailToReceiveNextQuestion(with: QuestionFactoryError.emptyQuestionsList)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            guard let moviesIndex = (0..<self.movies.count).randomElement() else {
                delegate?.didFailToReceiveNextQuestion(with: QuestionFactoryError.questionPreparationFailed)
                return
            }
            
            guard let movie = self.movies[safe: moviesIndex] else {
                delegate?.didFailToReceiveNextQuestion(with: QuestionFactoryError.questionPreparationFailed)
                return
            }
            
            let imageData: Data
            
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            } catch {
                delegate?.didFailToReceiveNextQuestion(with: QuestionFactoryError.loadQuestionImageFailed)
                return
            }
            
            guard let movieRating = Double(movie.rating) else {
                delegate?.didFailToReceiveNextQuestion(with: QuestionFactoryError.questionPreparationFailed)
                return
            }
            
            let randomRating = randomRatingValue
            let comparisionOperator = ComparisonOperator.random()

            let question = QuizQuestion(
                imageData: imageData,
                text: "Рейтинг этого фильма \(comparisionOperator.description) чем \(randomRating)?",
                correctAnswer: compare(
                    movieRating: movieRating,
                    with: Double(randomRating),
                    using: comparisionOperator
                ) ? .yes : .no
            )
            
            delegate?.didReceiveNextQuestion(question)
        }
    }
}

// MARK: - Private methods

private extension IMDbQuestionFactory {
    var randomRatingValue: Int {
        Int.random(in: randomRatingRange)
    }
    
    func compare(movieRating: Double, with randomRating: Double, using operator: ComparisonOperator) -> Bool {
        switch `operator` {
        case .greaterThan:
            return movieRating > randomRating
        case .lessThan:
            return movieRating < randomRating
        }
    }
}

private extension IMDbQuestionFactory {
    enum ComparisonOperator {
        case greaterThan
        case lessThan
        
        static func random() -> ComparisonOperator {
            return Int.random(in: 0...1) == 0 ? .greaterThan : .lessThan
        }
        
        var description: String {
            switch self {
            case .greaterThan:
                return "больше"
            case .lessThan:
                return "меньше"
            }
        }
    }
}
