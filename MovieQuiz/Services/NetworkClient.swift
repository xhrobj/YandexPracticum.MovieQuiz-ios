//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

struct NetworkClient {
    func fetch(endpoint: String, handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            handler(.failure(NetworkClientError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkClientError.codeError))
                
                return
            }
            
            guard let data else {
                handler(.failure(NetworkClientError.codeError))
                return
            }
            
            handler(.success(data))
        }
        
        task.resume()
    }
}

private extension NetworkClient {
    enum NetworkClientError: Error {
        case invalidURL
        case codeError
    }
}
