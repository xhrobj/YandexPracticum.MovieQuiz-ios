//
//  StatisticsServiceProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 18.11.2023.
//

protocol StatisticsServiceProtocol {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
    
    func storeGameResult(totalAnswers: Int, correctAnswers: Int)
}
