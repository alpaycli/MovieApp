//
//  MovieSearchDataService.swift
//  MovieApp
//
//  Created by Alpay Calalli on 24.10.23.
//

import Foundation

final class MovieSearchDataService {
    func getMovies(searchText: String) async throws -> [SearchMovie] {
        let headers = [
            "Authorization": Const.auth,
            "accept": Const.accept
        ]
        
        guard let urlString = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Const.apiKey)&language=en-US&page=1&include_adult=false&query=\(searchText)") else {
            throw APIError.badURL
        }
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        print("URLRequest", urlRequest)
        do {
            let movies = try await APIService.shared.fetch(SearchMovieResponse.self, url: urlRequest)
            return movies.results
        } catch {
            print("error.localizedDescription", error.localizedDescription)
            throw APIError.parsing(error as? DecodingError)
        }
    }
}

