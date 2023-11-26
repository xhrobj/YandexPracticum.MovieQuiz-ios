//
//  IMDbMovieDTO.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

struct IMDbMovieDTO: Decodable {
    let title: String
    let rating: String
    let image: String
}

private extension IMDbMovieDTO {
    enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case image
    }
}
