//
//  TopRatedFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 02.07.23.
//

import Foundation

class TopRatedFetcher: ObservableObject {
    let const = Const()
    
    @Published var topRatedMovies: [ResultMovie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchTopRatedMovies()
    }
    
    func fetchTopRatedMovies() {
        
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": const.auth,
            "accept": const.accept
        ]
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        let service = APIService()
        
        
        service.fetch(Movie.self, url: urlRequest) { result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let movie):
                    print("--- sucess with \(movie.results.count)")
                    self.topRatedMovies = movie.results
                }
            }
            
        }
    }
}
