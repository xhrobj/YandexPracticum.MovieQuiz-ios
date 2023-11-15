import UIKit

final class MovieQuizViewController: UIViewController {
    private static let nextQuestionDelayInSeconds: TimeInterval = 1
    
    private let questionsAmount = 10
    
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var displayedQuestionsCount = 0
    private var correctAnswers = 0
    
    private lazy var alertPresenter: AlertPresenterProtocol = {
        AlertPresenter()
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
        
        configureQuestionFactory()
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
    func handleAnswerAndMoveNextStep(userAnswer answer: AnswerResultType) {
        let isCorrect = isCorrectAnswer(answer)
        if isCorrect {
            correctAnswers += 1
        }
        
        showAnswerResult(isCorrect)

        DispatchQueue.main.asyncAfter(deadline: .now() + Self.nextQuestionDelayInSeconds) { [weak self] in
            self?.showNextQuestionOrResults()
        }
    }
    
    func showNextQuestionOrResults() {
        guard !isLastQuestion() else {
            showResults()
            return
        }
        
        fetchNextQuestion()
    }
    
    func showQuestion() {
        guard let currentQuestion = currentQuestion else { return }
        
        displayedQuestionsCount += 1
        let viewModel = convert(model: currentQuestion)
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
            message: "Ваш результат: \(correctAnswers)/\(questionsAmount)",
            buttonTitle: "Сыграть ещё раз",
            imageBorder: .none
        )
        updateView(with: viewModel)
    }
    
    func showStartState() {
        let viewModel = QuizStepViewModel(
            questionNumber: "",
            question: "",
            image: UIImage(),
            imageBorder: .none,
            buttonsEnabled: false
        )
        updateView(with: viewModel)
    }
    
    func startQuiz() {
        resetCounters()
        showStartState()
        fetchNextQuestion()
    }
}

// MARK: -

private extension MovieQuizViewController {
    func updateView(with viewModel: QuizResultsViewModel) {
        let alertModel = AlertModel(
            title: viewModel.title,
            message: viewModel.message,
            buttonTitle: viewModel.buttonTitle,
            buttonHandler: { [weak self] in self?.startQuiz() }
        )
        alertPresenter.present(alertModel, for: self)
        
        updateMovieImageViewBorder(with: viewModel.imageBorder)
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
        movieImageView.image = nil
    }
    
    func configureQuestionFactory() {
        questionFactory = QuestionFactory()
        questionFactory?.delegate = self
    }
}

// MARK: - Data/Model

private extension MovieQuizViewController {
    func fetchNextQuestion() {
        questionFactory?.requestNextQuestion()
    }
    
    func isCorrectAnswer(_ answer: AnswerResultType) -> Bool {
        currentQuestion?.correctAnswer == answer
    }
    
    func isLastQuestion() -> Bool {
        displayedQuestionsCount == questionsAmount
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            questionNumber: "\(displayedQuestionsCount)/\(questionsAmount)",
            question: model.text,
            image: UIImage(named: model.imageName) ?? UIImage(),
            imageBorder: .none,
            buttonsEnabled: true
        )
    }
    
    func resetCounters() {
        displayedQuestionsCount = 0
        correctAnswers = 0
    }
}

// MARK: - <QuestionFactoryDelegate>

extension MovieQuizViewController: QuestionFactoryDelegate {
    func didReceiveNextQuestion(_ question: QuizQuestion?) {
        currentQuestion = question
        
        DispatchQueue.main.async { [weak self] in
            self?.showQuestion()
        }
    }
}
