//
//  NetworkRouting.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 08.12.2023.
//

import Foundation

protocol NetworkRouting {
    func fetch(endpoint: String, handler: @escaping (Result<Data, Error>) -> Void)
}
