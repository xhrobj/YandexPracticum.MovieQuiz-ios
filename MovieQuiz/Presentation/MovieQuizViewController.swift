import UIKit

final class MovieQuizViewController: UIViewController {
    private var questions: [QuizQuestion] = []
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadData()
        showNextQuestion()
    }
}

// MARK: - @IBActions

private extension MovieQuizViewController {
    @IBAction func noButtonTapped() {
        let userAnswer = AnswerResult.no
        handleAnswerAndMoveNextStep(userAnswer)
    }
    
    @IBAction func yesButtonTapped() {
        let userAnswer = AnswerResult.yes
        handleAnswerAndMoveNextStep(userAnswer)
    }
}

// MARK: - Private methods

private extension MovieQuizViewController {
    func handleAnswerAndMoveNextStep(_ answer: AnswerResult) {
        let isCorrect = isCorrectAnswer(answer)
        correctAnswers += isCorrect ? 1 : 0
        
        showAnswerResult(isCorrect)
        
        let delayInSeconds: Double = 1
        // запускаем задачу через 1 секунду c помощью диспетчера задач
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            // код, который мы хотим вызвать через 1 секунду
            self.showNextQuestionOrResults()
        }
    }
    
    func showAnswerResult(_ isCorrectAnswer: Bool) {
        let borderColor: UIColor = isCorrectAnswer ? .ypGreen : .ypRed
        updateMovieImageViewBorder(with: borderColor)
    }
    
    func showNextQuestionOrResults() {
        guard !isLastQuestion() else {
            showResults()
            return
        }

        showNextQuestion()
    }
    
    func showResults() {
        // показываем финальный результат
    }
    
    func showNextQuestion() {
        currentQuestionIndex += 1
        let viewModel = convert(model: currentQuestion())
        updateView(with: viewModel)
    }
}

// MARK: -

private extension MovieQuizViewController {
    func updateView(with viewModel: QuizStepViewModel) {
        counterLabel.text = viewModel.questionNumber
        questionLabel.text = viewModel.question
        movieImageView.image = viewModel.image
        updateMovieImageViewBorder(with: .clear)
    }
    
    func updateMovieImageViewBorder(with color: UIColor) {
        movieImageView.layer.borderColor = color.cgColor
    }
    
    func setupView() {
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.borderWidth = 8
        movieImageView.layer.cornerRadius = 20
    }
}

// MARK: - Data

private extension MovieQuizViewController {
    func isCorrectAnswer(_ answer: AnswerResult) -> Bool {
        currentQuestion().correctAnswer == answer
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex + 1 >= questions.count
    }
    
    func currentQuestion() -> QuizQuestion {
        questions[currentQuestionIndex]
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)",
            question: model.text,
            image: UIImage(named: model.imageName) ?? UIImage()
        )
    }
    
    func loadData() {
        questions = [
            QuizQuestion(
                imageName: "The Godfather",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 9,2
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "The Dark Knight",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 9
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "Kill Bill",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 8,1
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "The Avengers",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 8
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "Deadpool",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 8
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "The Green Knight",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 6,6
                correctAnswer: .yes
            ),
            QuizQuestion(
                imageName: "Old",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 5,8
                correctAnswer: .no
            ),
            QuizQuestion(
                imageName: "The Ice Age Adventures of Buck Wild",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 4,3
                correctAnswer: .no
            ),
            QuizQuestion(
                imageName: "Tesla",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 5,1
                correctAnswer: .no
            ),
            QuizQuestion(
                imageName: "Vivarium",
                text: "Рейтинг этого фильма больше чем 6?", // NOTE: 5,8
                correctAnswer: .no
            )
        ]
    }
}

// MARK: - Model

// NOTE: Спринт 4/17: 4 → Тема 3/4: Реализация логики по макету → Урок 2/6
// Для своего первого проекта мы будем пользоваться только файлом MovieQuizViewController.swift — весь код напишем в нём.
// Если понадобится создать дополнительные классы или структуры, их также стоит расположить внутри этого файла.

private enum AnswerResult {
    case yes, no
}

private struct QuizQuestion {
    let imageName: String // NOTE: совпадает с названием картинки афиши фильма в Assets
    let text: String
    let correctAnswer: AnswerResult
}

private struct QuizStepViewModel {
    let questionNumber: String
    let question: String
    let image: UIImage
}
