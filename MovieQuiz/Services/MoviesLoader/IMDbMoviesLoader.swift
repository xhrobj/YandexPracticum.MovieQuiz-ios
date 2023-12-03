//
//  IMDbMoviesLoader.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

struct IMDbMoviesLoader: MoviesLoadingProtocol {
    private let imdbAPIKey = "k_zcuw1ytf"
    private let baseUrl = "https://imdb-api.com/en/API/"
    private let top250MoviesPath = "Top250Movies/"
    
    private let networkClient = NetworkClient()
    
    private var mostPopularMoviesEndpoint: String {
        baseUrl + top250MoviesPath + imdbAPIKey
    }
    
    func loadMovies(handler: @escaping (Result<IMDbMoviesListDTO, Error>) -> Void) {
        networkClient.fetch(endpoint: mostPopularMoviesEndpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let moviesList = try JSONDecoder().decode(IMDbMoviesListDTO.self, from: data)
                    
                    guard moviesList.errorMessage.isEmpty else {
                        handler(.failure(IMDbMoviesLoaderError.apiError))
                        
                        return
                    }
                    
                    handler(.success(moviesList))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

private extension IMDbMoviesLoader {
    enum IMDbMoviesLoaderError: Error {
        case apiError
    }
}
