//
//  APIService.swift
//  MovieApp
//
//  Created by Alpay Calalli on 16.07.23.
//

import Combine
import Foundation

class APIService {
    static let shared = APIService()
    private init() { }
    
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

final class NetworkManager {
    
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleURLResponse(output: $0, url: url) } )
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw APIError.badResponse(statusCode: 300)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
