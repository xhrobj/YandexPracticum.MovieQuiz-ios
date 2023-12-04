//
//  IMDbMovieDTO.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

struct IMDbMovieDTO: Decodable {
    let title: String
    let rating: String
    let imageURL: URL
}

private extension IMDbMovieDTO {
    enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
    }
}
