//
//  QuestionFactoryError.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 03.12.2023.
//

import Foundation

enum QuestionFactoryError: LocalizedError {
    case emptyQuestionsList
    case loadQuestionImageFailed
    case questionPreparationFailed
    
    var errorDescription: String? {
        switch self {
        case .emptyQuestionsList:
            return "Нет списка вопросов"
        case .loadQuestionImageFailed:
            return "Не удалось получить изображение для вопроса"
        case .questionPreparationFailed:
            return "Другая ошибка подготовки вопроса"
        }
    }
}
