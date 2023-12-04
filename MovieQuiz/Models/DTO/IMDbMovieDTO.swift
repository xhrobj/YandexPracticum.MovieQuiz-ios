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
    
    /// URL изображения более высокого качества
    var resizedImageURL: URL {
        let urlString = imageURL.absoluteString
        
        guard var imageUrlString = urlString.components(separatedBy: "._")[safe: 0] else {
            return imageURL
        }
        
        imageUrlString += "._V0_UX600_.jpg"
        
        guard let newURL = URL(string: imageUrlString) else {
            return imageURL
        }
        
        return newURL
    }
}

private extension IMDbMovieDTO {
    enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
    }
}
