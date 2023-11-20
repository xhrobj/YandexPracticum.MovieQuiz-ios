//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 15.11.2023.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    func present(_ model: AlertModel, for vc: UIViewController) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: model.buttonTitle, style: .default) { _ in
            model.buttonHandler()
        }
        alert.addAction(action)
        
        vc.present(alert, animated: true)
    }
}
