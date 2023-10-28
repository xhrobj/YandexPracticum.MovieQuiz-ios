import UIKit

final class MovieQuizViewController: UIViewController {
    
    private var questions: [QuizQuestion] = []
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        showNextQuestion()
    }
}

// MARK: - @IBActions

private extension MovieQuizViewController {
    @IBAction func noButtonTapped() {
        print("no")
    }
    
    @IBAction func yesButtonTapped() {
        print("yes")
    }
}

// MARK: - Private methods

private extension MovieQuizViewController {
    func showNextQuestion() {
        let viewModel = convert(model: questions[currentQuestionIndex])
        updateView(with: viewModel)
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)",
            question: model.question,
            image: UIImage(named: model.image) ?? UIImage()
        )
    }
    
    func updateView(with viewModel: QuizStepViewModel) {
        counterLabel.text = viewModel.questionNumber
        moviePosterImageView.image = viewModel.image
        questionLabel.text = viewModel.question
    }
    
}

// MARK: - Data

private extension MovieQuizViewController {
    func loadData() {
        questions = [
            QuizQuestion(
                image: "The Godfather",
                question: "Рейтинг этого фильма больше чем 6?", // 9,2
                isCorrectAnswer: true
            ),
            QuizQuestion(
                image: "The Dark Knight",
                question: "Рейтинг этого фильма больше чем 6?", // 9
                isCorrectAnswer: true
            ),
            QuizQuestion(
                image: "Kill Bill",
                question: "Рейтинг этого фильма больше чем 6?", // 8,1
                isCorrectAnswer: true
            ),
            QuizQuestion(
                image: "The Avengers",
                question: "Рейтинг этого фильма больше чем 6?", // 8
                isCorrectAnswer: true
            ),
            QuizQuestion(
                image: "Deadpool",
                question: "Рейтинг этого фильма больше чем 6?", // 8
                isCorrectAnswer: true
            ),
            QuizQuestion(
                image: "The Green Knight",
                question: "Рейтинг этого фильма больше чем 6?", // 6,6
                isCorrectAnswer: true
            ),
            QuizQuestion(
                image: "Old",
                question: "Рейтинг этого фильма больше чем 6?", // 5,8
                isCorrectAnswer: false
            ),
            QuizQuestion(
                image: "The Ice Age Adventures of Buck Wild",
                question: "Рейтинг этого фильма больше чем 6?", // 4,3
                isCorrectAnswer: false
            ),
            QuizQuestion(
                image: "Tesla",
                question: "Рейтинг этого фильма больше чем 6?", // 5,1
                isCorrectAnswer: false
            ),
            QuizQuestion(
                image: "Vivarium",
                question: "Рейтинг этого фильма больше чем 6?", // 5,8
                isCorrectAnswer: false
            )
        ]
    }
}

// MARK: - Model

// NOTE: Спринт 4/17: 4 → Тема 3/4: Реализация логики по макету → Урок 2/6
// Для своего первого проекта мы будем пользоваться только файлом MovieQuizViewController.swift — весь код напишем в нём.
// Если понадобится создать дополнительные классы или структуры, их также стоит расположить внутри этого файла.

struct QuizQuestion {
    let image: String // совпадает с названием картинки афиши фильма в Assets
    let question: String // строка с вопросом о рейтинге фильма
    let isCorrectAnswer: Bool // правильный ответ на вопрос
}

struct QuizStepViewModel {
    let questionNumber: String
    let question: String
    let image: UIImage
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
