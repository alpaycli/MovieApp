//
//  MoviesDataService.swift
//  MovieApp
//
//  Created by Alpay Calalli on 23.10.23.
//

import Foundation

final class MoviesDataService: ObservableObject {
    
    func getMovies(type: MovieCategory) async throws -> [Movie] {
        let headers = [
            "Authorization": Const.auth,
            "accept": Const.accept
        ]
        
        guard let urlString = URL(string: "https://api.themoviedb.org/3/movie/\(type.rawValue)?language=en-US&page=1") else {
            throw APIError.badURL
        }
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        do {
            let movie = try await APIService.shared.fetch(MovieResponse.self, url: urlRequest)
            return movie.results
        } catch {
            print(error.localizedDescription)
            throw APIError.parsing(error as? DecodingError)
        }
    }
}
