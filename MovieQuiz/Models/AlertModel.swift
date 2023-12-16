//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 15.11.2023.
//

struct AlertModel {
    let accessibilityIdentifier: String?
    let title: String?
    let message: String?
    let buttonTitle: String
    let buttonHandler: () -> Void
}
