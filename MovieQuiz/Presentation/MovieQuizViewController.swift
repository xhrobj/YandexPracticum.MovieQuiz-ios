import UIKit

final class MovieQuizViewController: UIViewController {
    private var presenter: MovieQuizPresenter!
    private lazy var alertPresenter: AlertPresenterProtocol = AlertPresenter()
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configurePresenter()
    }
}

// MARK: - @IBActions

private extension MovieQuizViewController {
    @IBAction func noButtonTapped() {
        presenter.noButtonTapped()
    }
    
    @IBAction func yesButtonTapped() {
        presenter.yesButtonTapped()
    }
}

// MARK: - Class API

extension MovieQuizViewController {
    func showLoadingState() {
        loadingActivityIndicator.startAnimating()
    }
    
    func hideLoadingState() {
        loadingActivityIndicator.stopAnimating()
    }
    
    func showStartState(_ viewModel: QuizStepViewModel) {
        configureView(with: viewModel)
    }
    
    func showQuestion(_ viewModel: QuizStepViewModel) {
        configureView(with: viewModel)
    }

    func showAnswerResult(_ viewModel: QuizAnswerViewModel) {
        configureView(with: viewModel)
    }
    
    func showGameResults(_ viewModel: QuizResultsViewModel) {
        configureView(with: viewModel)
    }
    
    func showError(_ viewModel: QuizErrorViewModel) {
        configureView(with: viewModel)
    }
}

// MARK: - Private methods

private extension MovieQuizViewController {
    func configureView(with viewModel: QuizStepViewModel) {
        counterLabel.text = viewModel.questionNumber
        questionLabel.text = viewModel.question
        movieImageView.image = viewModel.image
        configureMovieImageViewBorder(with: viewModel.imageBorder)
        configureButtons(isEnabled: viewModel.isButtonsEnabled)
    }
    
    func configureView(with viewModel: QuizAnswerViewModel) {
        configureMovieImageViewBorder(with: viewModel.imageBorder)
        configureButtons(isEnabled: viewModel.isButtonsEnabled)
    }
    
    func configureView(with viewModel: QuizResultsViewModel) {
        configureMovieImageViewBorder(with: viewModel.imageBorder)
        
        let alertModel = AlertModel(
            accessibilityIdentifier: viewModel.accessibilityIdentifier,
            title: viewModel.title,
            message: viewModel.message,
            buttonTitle: viewModel.buttonTitle,
            buttonHandler: { [weak self] in self?.presenter.restartQuiz() }
        )
        alertPresenter.present(alertModel, for: self)
    }
    
    func configureView(with viewModel: QuizErrorViewModel) {
        let alertModel = AlertModel(
            accessibilityIdentifier: viewModel.accessibilityIdentifier,
            title: "Что-то пошло не так(",
            message: viewModel.message,
            buttonTitle: "Попробовать еще раз",
            buttonHandler: viewModel.retryAction
        )
        alertPresenter.present(alertModel, for: self)
    }
    
    func configureMovieImageViewBorder(with type: MovieImageBorderType) {
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
    
    func configureButtons(isEnabled: Bool) {
        noButton.isEnabled = isEnabled
        yesButton.isEnabled = isEnabled
    }

    func configureView() {
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.borderWidth = 8
        movieImageView.layer.cornerRadius = 20
        movieImageView.image = nil
        
        questionLabel.text = nil
        
        configureMovieImageViewBorder(with: .none)
        configureButtons(isEnabled: false)
    }
}

// MARK: -

private extension MovieQuizViewController {
    func configurePresenter() {
        presenter = MovieQuizPresenter(viewController: self)
    }
}
