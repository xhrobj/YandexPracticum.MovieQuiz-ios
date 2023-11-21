//
//  StatisticsService.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 18.11.2023.
//

import Foundation

final class StatisticsService: StatisticsServiceProtocol {
    private let userDefaults = UserDefaults.standard

    var averageAccuracyPercentage: Double {
        get {
            let savedTotalAnswers = totalAnswers
            
            guard savedTotalAnswers != 0 else { return 0 }
            
            return Double(totalCorrectAnswers) / Double(savedTotalAnswers) * 100
        }
    }

    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data)
            else {
                return .init(totalAnswers: 0, correctAnswers: 0, date: Date())
            }
            
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func storeGameResult(totalAnswers: Int, correctAnswers: Int) {
        let lastGame = GameRecord(
            totalAnswers: totalAnswers,
            correctAnswers: correctAnswers,
            date: Date()
        )
        if lastGame.isBetterThan(bestGame) {
            bestGame = lastGame
        }
        
        self.totalAnswers += totalAnswers
        totalCorrectAnswers += correctAnswers
        gamesCount += 1
    }
    
    func reset() {
        let keys: [Keys] = [.totalAnswers, .totalCorrectAnswers, .gamesCount, .bestGame]
        keys.forEach { key in
            userDefaults.removeObject(forKey: key.rawValue)
        }
    }
}

// MARK: - Private methods

private extension StatisticsService {
    private var totalAnswers: Int {
        get {
            userDefaults.integer(forKey: Keys.totalAnswers.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.totalAnswers.rawValue)
        }
    }
    
    private var totalCorrectAnswers: Int {
        get {
            userDefaults.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.totalCorrectAnswers.rawValue)
        }
    }
}

// MARK: - Keys

private extension StatisticsService {
    enum Keys: String {
        case totalAnswers, totalCorrectAnswers, gamesCount, bestGame
    }
}
