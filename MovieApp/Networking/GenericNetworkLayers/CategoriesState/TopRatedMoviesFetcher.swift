//
//  TopRatedMoviesFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 16.07.23.
//

import Foundation

class TopRatedFetcher: ObservableObject {
    let const = Const()
    
    @Published var topRatedMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    let service: APIService
    
    init(service: APIService) {
        self.service = service
        fetchTopRatedMovies()
    }
    
    func fetchTopRatedMovies() {
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": const.auth,
            "accept": const.accept
        ]
        
        Task {
            do {
                var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")!)
                
                urlRequest.httpMethod = "GET"
                urlRequest.allHTTPHeaderFields = headers
                
                let movies: MovieResponse = try await service.fetch(MovieResponse.self, url: urlRequest)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.topRatedMovies = movies.results
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