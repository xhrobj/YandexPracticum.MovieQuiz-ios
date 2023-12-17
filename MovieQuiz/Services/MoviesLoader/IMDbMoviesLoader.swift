//
//  IMDbMoviesLoader.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

struct IMDbMoviesLoader {
    private let imdbAPIKey = "k_zcuw1ytf"
    
    private let baseUrl = "https://imdb-api.com/en/API/"
    private let top250MoviesPath = "Top250Movies/"
    
    private let networkClient: NetworkRouting
    
    private var mostPopularMoviesEndpoint: String {
        baseUrl + top250MoviesPath + imdbAPIKey
    }
    
    init(networkClient: NetworkRouting = NetworkClient()) {
        self.networkClient = networkClient
    }
}

// MARK: - <IMDbMoviesLoadingProtocol>

extension IMDbMoviesLoader: IMDbMoviesLoadingProtocol {
    func loadMovies(handler: @escaping (Result<[IMDbMovieDTO], Error>) -> Void) {
        networkClient.fetch(endpoint: mostPopularMoviesEndpoint) { result in
            switch result {
            case .success(let data):
                let moviesList: IMDbMoviesListDTO
                
                do {
                    moviesList = try JSONDecoder().decode(IMDbMoviesListDTO.self, from: data)
                } catch {
                    handler(.failure(error))
                    return
                }
                
                guard moviesList.errorMessage.isEmpty else {
                    handler(.failure(IMDbMoviesLoaderError.apiError(message: moviesList.errorMessage)))
                    return
                }
                
                guard !moviesList.items.isEmpty else {
                    handler(.failure(IMDbMoviesLoaderError.emptyData))
                    return
                }
                
                handler(.success(moviesList.items))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

// MARK: -

private extension IMDbMoviesLoader {
    enum IMDbMoviesLoaderError: LocalizedError {
        case apiError (message: String)
        case emptyData
        
        var errorDescription: String? {
            switch self {
            case .apiError (let message):
                return "Ответ API: \(message)"
            case .emptyData:
                return "Полученный список вопросов пуст"
            }
        }
    }
}
