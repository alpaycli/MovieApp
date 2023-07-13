//
//  APIService.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import Foundation

class APIService {
    
    func fetch<T: Decodable>(_ type: T.Type, url: URLRequest) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(for: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badResponse(statusCode: response.hash)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.badResponse(statusCode: httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedItems = try decoder.decode(type, from: data)
            return decodedItems
        } catch {
            throw APIError.parsing(error as? DecodingError)
        }
    }
}


