//
//  MoviesLoadingProtocol.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

protocol MoviesLoadingProtocol {
    func loadMovies(handler: @escaping (Result<IMDbMoviesListDTO, Error>) -> Void)
}
