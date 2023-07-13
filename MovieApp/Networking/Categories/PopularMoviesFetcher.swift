//
//  PopularMoviesFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import Foundation

class PopularMoviesFetcher: ObservableObject {
    let const = Const()
    
    @Published var popularMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    let service: APIService
    
    init(service: APIService) {
        self.service = service
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": const.auth,
            "accept": const.accept
        ]
        
        Task {
            do {
                var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")!)
                
                urlRequest.httpMethod = "GET"
                urlRequest.allHTTPHeaderFields = headers
                
                let movies: MovieResponse = try await service.fetch(MovieResponse.self, url: urlRequest)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.popularMovies = movies.results
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
