//
//  RecommendationsFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 02.07.23.
//

import Foundation

class MoreMoviesFetcher: ObservableObject {
    @Published var moreMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
        fetchMoreMovies()
    }
    
    func fetchMoreMovies() {
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": Const.auth,
            "accept": Const.accept
        ]
        
        Task {
            do {
                var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?language=en-US&page=1")!)
                
                urlRequest.httpMethod = "GET"
                urlRequest.allHTTPHeaderFields = headers
                
                let movies: MovieResponse = try await APIService.shared.fetch(MovieResponse.self, url: urlRequest)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.moreMovies = movies.results
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

}
