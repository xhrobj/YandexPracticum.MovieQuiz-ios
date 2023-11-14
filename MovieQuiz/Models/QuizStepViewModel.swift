//
//  QuizStepViewModel.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 14.11.2023.
//

import UIKit

struct QuizStepViewModel {
    let questionNumber: String
    let question: String
    let image: UIImage
    let imageBorder: MovieImageBorderType
    let buttonsEnabled: Bool
}
