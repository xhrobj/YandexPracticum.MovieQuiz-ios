//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 16.12.2023.
//

import UIKit

final class MovieQuizPresenter {
    private let nextQuestionDelayInSeconds: TimeInterval = 1
    private let questionsAmount = 10

    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var displayedQuestionsCount = 0
    private var correctAnswers = 0

    private lazy var statisticsService: StatisticsServiceProtocol = StatisticsService()
    
    weak var viewController: MovieQuizViewControllerProtocol?
    
    init(viewController: MovieQuizViewControllerProtocol) {
        self.viewController = viewController
        
        configureQuestionFactory()
        loadData()
    }
}

// MARK: - Class API

extension MovieQuizPresenter {
    func noButtonTapped() {
        handleAnswerAndMoveNextStep(userAnswer: .no)
    }
    
    func yesButtonTapped() {
        handleAnswerAndMoveNextStep(userAnswer: .yes)
    }

    func restartQuiz() {
        startQuiz()
    }
}

// MARK: - <QuestionFactoryDelegate>

extension MovieQuizPresenter: QuestionFactoryDelegate {
    func didLoadQuestions() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.hideLoadingState()
            self?.startQuiz()
        }
    }
    
    func didReceiveNextQuestion(_ question: QuizQuestion) {
        currentQuestion = question
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.hideLoadingState()
            self?.showQuestion()
        }
    }
    
    func didFailToLoadQuestionsList(with error: Error) {
        let viewModel = QuizErrorViewModel(
            accessibilityIdentifier: "LoadQuestionsListError",
            message: "Невозможно загрузить данные\n[\(error.localizedDescription)]",
            retryAction: { [weak self] in self?.loadData() }
        )

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.hideLoadingState()
            self?.viewController?.showError(viewModel)
        }
    }

    func didFailToReceiveNextQuestion(with error: Error) {
        let viewModel = QuizErrorViewModel(
            accessibilityIdentifier: "ReceiveNextQuestionError",
            message: "Невозможно загрузить данные вопроса\n[\(error.localizedDescription)]",
            retryAction: { [weak self] in self?.fetchNextQuestion() }
        )

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.hideLoadingState()
            self?.viewController?.showError(viewModel)
        }
    }
}

// MARK: - Private methods

private extension MovieQuizPresenter {
    func loadData() {
        viewController?.showLoadingState()
        questionFactory?.loadQuestionsList()
    }
    
    func startQuiz() {
        resetCounters()
        showStartState()
        fetchNextQuestion()
    }
    
    func resetCounters() {
        displayedQuestionsCount = 0
        correctAnswers = 0
    }
    
    func fetchNextQuestion() {
        viewController?.showLoadingState()
        questionFactory?.requestNextQuestion()
    }
    
    func handleAnswerAndMoveNextStep(userAnswer answer: AnswerResultType) {
        let isCorrect = isCorrectAnswer(answer)
        if isCorrect {
            correctAnswers += 1
        }
        
        showAnswerResult(isCorrect)

        DispatchQueue.main.asyncAfter(deadline: .now() + nextQuestionDelayInSeconds) { [weak self] in
            self?.showNextQuestionOrResults()
        }
    }
    
    func isLastQuestion() -> Bool {
        displayedQuestionsCount == questionsAmount
    }
    
    func isCorrectAnswer(_ answer: AnswerResultType) -> Bool {
        currentQuestion?.correctAnswer == answer
    }

    func saveResults() {
        statisticsService.storeGameResult(totalAnswers: questionsAmount, correctAnswers: correctAnswers)
    }

    func viewModel(from model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            questionNumber: "\(displayedQuestionsCount)/\(questionsAmount)",
            question: model.text,
            image: UIImage(data: model.imageData) ?? UIImage(),
            imageBorder: .none,
            isButtonsEnabled: true
        )
    }
}

// MARK: -

private extension MovieQuizPresenter {
    func showStartState() {
        let viewModel = QuizStepViewModel(
            questionNumber: "",
            question: "",
            image: UIImage(),
            imageBorder: .none,
            isButtonsEnabled: false
        )
        viewController?.showStartState(viewModel)
    }
    
    func showQuestion() {
        guard let currentQuestion = currentQuestion else { return }
        
        displayedQuestionsCount += 1
        let viewModel = viewModel(from: currentQuestion)
        viewController?.showQuestion(viewModel)
    }
    
    func showAnswerResult(_ isCorrectAnswer: Bool) {
        let viewModel = QuizAnswerViewModel(
            imageBorder: isCorrectAnswer ? .correct : .wrong,
            isButtonsEnabled: false
        )
        viewController?.showAnswerResult(viewModel)
    }
    
    func showNextQuestionOrResults() {
        guard !isLastQuestion() else {
            saveResults()
            showGameResults()
            
            return
        }
        
        fetchNextQuestion()
    }
    
    func showGameResults() {
        let bestGame = statisticsService.bestGame
        let message = """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Количество сыгранных квизов: \(statisticsService.gamesCount)
            Рекорд: \(bestGame.correctAnswers)/\(bestGame.totalAnswers) (\(bestGame.date.dateTimeString))
            Средняя точность: \(String(format: "%.2f", statisticsService.averageAccuracyPercentage))%
            """
        
        let viewModel = QuizResultsViewModel(
            accessibilityIdentifier: "GameResults",
            title: "Этот раунд окончен!",
            message: message,
            buttonTitle: "Сыграть ещё раз",
            imageBorder: .none
        )
        viewController?.showGameResults(viewModel)
    }
}

// MARK: -

private extension MovieQuizPresenter {
    func configureQuestionFactory() {
        configureIMDbQuestionFactory()
    }
    
    func configureMockQuestionFactory() {
        questionFactory = MockQuestionFactory()
        questionFactory?.delegate = self
    }
    
    func configureIMDbQuestionFactory() {
        questionFactory = IMDbQuestionFactory(moviesLoader: IMDbMoviesLoader(), delegate: self)
    }
}

// MARK: -

// NOTE: в задании есть требование протестировать у презентера приватный метод конвертации модели,
// откроем доступ к нему через этот экстеншн;
// используется в тесте: MovieQuizPresenterTests/testPresenterConvertModel()
extension MovieQuizPresenter {
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        viewModel(from: model)
    }
}
