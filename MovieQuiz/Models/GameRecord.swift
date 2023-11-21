//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 18.11.2023.
//

import Foundation

struct GameRecord: Codable {
    let totalAnswers: Int
    let correctAnswers: Int
    let date: Date
    
    func isBetterThan(_ other: GameRecord) -> Bool {
        if totalAnswers == 0 {
            return false
        } else if other.totalAnswers == 0 {
            return true
        }
        
        let accuracy = Double(correctAnswers) / Double(totalAnswers)
        let otherAccuracy = Double(other.correctAnswers) / Double(other.totalAnswers)
        
        return accuracy > otherAccuracy
    }
}
