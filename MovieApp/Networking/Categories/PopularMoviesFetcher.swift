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
    
    init() {
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": const.auth,
            "accept": const.accept
        ]
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        let service = APIService()
        
        
        service.fetch(MovieResponse.self, url: urlRequest) { result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let movie):
                    print("--- sucess with \(movie.results.count)")
                    self.popularMovies = movie.results
                }
            }
            
        }
        func successNowPlayingMovies() -> NowPlayingMoviesFetcher {
            let fetcher = NowPlayingMoviesFetcher()
            
            fetcher.nowPlayingMovies = Movie.exampleResult()
            
            return fetcher
        }
        
    }
}
