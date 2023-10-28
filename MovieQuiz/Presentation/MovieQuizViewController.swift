import UIKit

final class MovieQuizViewController: UIViewController {
    private static let nextQuestionDelayInSeconds: TimeInterval = 1
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    private lazy var questions: [QuizQuestion] = {
        loadQuestions()
    }()
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startQuiz()
    }
}

// MARK: - @IBActions

private extension MovieQuizViewController {
    @IBAction func noButtonTapped() {
        handleAnswerAndMoveNextStep(userAnswer: .no)
    }
    
    @IBAction func yesButtonTapped() {
        handleAnswerAndMoveNextStep(userAnswer: .yes)
    }
}

// MARK: - Private methods

private extension MovieQuizViewController {
    func handleAnswerAndMoveNextStep(userAnswer answer: AnswerResult) {
        let isCorrect = isCorrectAnswer(answer)
        correctAnswers += isCorrect ? 1 : 0
        
        showAnswerResult(isCorrect)

        DispatchQueue.main.asyncAfter(deadline: .now() + Self.nextQuestionDelayInSeconds) {
            self.showNextQuestionOrResults()
        }
    }
    
    func showNextQuestionOrResults() {
        guard !isLastQuestion() else {
            showResults()
            return
        }
        
        currentQuestionIndex += 1
        showQuestion()
    }
    
    func showQuestion() {
        let viewModel = convert(model: currentQuestion())
        updateView(with: viewModel)
    }

    func showAnswerResult(_ isCorrectAnswer: Bool) {
        let viewModel = QuizAnswerViewModel(
            imageBorder: isCorrectAnswer ? .correct : .wrong,
            buttonsEnabled: false
        )
        updateView(with: viewModel)
    }

    func showResults() {
        let viewModel = QuizResultsViewModel(
            title: "Раунд окончен!",
            message: "Ваш результат: \(correctAnswers)/\(questions.count)",
            buttonTitle: "Сыграть ещё раз"
        )
        updateView(with: viewModel)
    }
    
    func startQuiz() {
        resetCounters()
        showQuestion()
    }
}

// MARK: -

private extension MovieQuizViewController {
    func updateView(with viewModel: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: viewModel.buttonTitle, style: .default) { _ in
            self.startQuiz()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func updateView(with viewModel: QuizAnswerViewModel) {
        updateMovieImageViewBorder(with: viewModel.imageBorder)
        updateButtons(isEnabled: viewModel.buttonsEnabled)
    }
    
    func updateView(with viewModel: QuizStepViewModel) {
        counterLabel.text = viewModel.questionNumber
        questionLabel.text = viewModel.question
        movieImageView.image = viewModel.image
        updateMovieImageViewBorder(with: viewModel.imageBorder)
        updateButtons(isEnabled: viewModel.buttonsEnabled)
    }

    func updateMovieImageViewBorder(with type: MovieImageBorderType) {
        let color: UIColor
        
        switch type {
        case .none:
            color = .clear
        case .correct:
            color = .ypGreen
        case .wrong:
            color = .ypRed
        }
        
        movieImageView.layer.borderColor = color.cgColor
    }
    
    func updateButtons(isEnabled: Bool) {
        noButton.isEnabled = isEnabled
        yesButton.isEnabled = isEnabled
    }
    
    func setupView() {
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.borderWidth = 8
        movieImageView.layer.cornerRadius = 20
    }
}

// MARK: - Data/Model

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
            image: UIImage(named: model.imageName) ?? UIImage(),
            imageBorder: .none,
            buttonsEnabled: true
        )
    }
    
    func resetCounters() {
        currentQuestionIndex = 0
        correctAnswers = 0
    }
    
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

// MARK: - Model

private enum AnswerResult {
    case yes, no
}

private struct QuizQuestion {
    let imageName: String // NOTE: совпадает с названием картинки афиши фильма в Assets
    let text: String
    let correctAnswer: AnswerResult
}

private enum MovieImageBorderType {
    case none, correct, wrong
}

private struct QuizStepViewModel {
    let questionNumber: String
    let question: String
    let image: UIImage
    let imageBorder: MovieImageBorderType
    let buttonsEnabled: Bool
}

private struct QuizAnswerViewModel {
    let imageBorder: MovieImageBorderType
    let buttonsEnabled: Bool
}

private struct QuizResultsViewModel {
    let title: String
    let message: String
    let buttonTitle: String
}
