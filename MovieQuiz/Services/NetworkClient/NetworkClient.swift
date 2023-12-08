//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Mikhail Eliseev on 26.11.2023.
//

import Foundation

struct NetworkClient: NetworkRouting {
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
            
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkClientError.invalidStatusCode))
                return
            }
            
            guard let data else {
                handler(.failure(NetworkClientError.invalidData))
                return
            }
            
            handler(.success(data))
        }
        
        task.resume()
    }
}

private extension NetworkClient {
    enum NetworkClientError: LocalizedError {
        case invalidURL
        case invalidStatusCode
        case invalidData
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Некорректный URL запроса"
            case .invalidStatusCode:
                return "Код ответа сервера не в пределах ожидаемого диапазона"
            case .invalidData:
                return "Ошибка при получении данных с сервера"
            }
        }
    }
}
