//
//  IMDbMoviesListDTO.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

struct IMDbMoviesListDTO: Decodable {
    let errorMessage: String
    let items: [IMDbMovieDTO]
}
