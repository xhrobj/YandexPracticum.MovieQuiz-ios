//
//  IMDbMoviesLoadingProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

protocol IMDbMoviesLoadingProtocol {
    func loadMovies(handler: @escaping (Result<[IMDbMovieDTO], Error>) -> Void)
}
