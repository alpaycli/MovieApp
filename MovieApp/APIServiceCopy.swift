//
//  APIService.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import Foundation

struct APIServiceCopy {
    
    func fetch<T: Decodable>(_ type: T.Type, url: URLRequest?) async throws -> T {
        
        guard let url = url else {
            throw APIError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: url)
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw APIError.badResponse(statusCode: response.hash)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
        
    }
}


