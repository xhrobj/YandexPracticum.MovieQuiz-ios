//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 15.11.2023.
//

import UIKit

protocol AlertPresenterProtocol: AnyObject {
    func present(_ model: AlertModel, for vc: UIViewController)
}
