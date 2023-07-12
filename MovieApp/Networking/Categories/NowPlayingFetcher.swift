//
//  NowPlayingFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import Foundation

class NowPlayingMoviesFetcher: ObservableObject {
    let const = Const()
    
    @Published var nowPlayingMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchNowPlayingMovies()
    }
    
    func fetchNowPlayingMovies() {
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": const.auth,
            "accept": const.accept
        ]
        
        let service = APIService()
        
        Task {
            do {
                var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1")!)
                
                urlRequest.httpMethod = "GET"
                urlRequest.allHTTPHeaderFields = headers
                
                let movies: MovieResponse = try await service.fetch(MovieResponse.self, url: urlRequest)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.nowPlayingMovies = movies.results
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func successNowPlayingMovies() -> NowPlayingMoviesFetcher {
        let fetcher = NowPlayingMoviesFetcher()
        
        fetcher.nowPlayingMovies = Movie.exampleResult()
        
        return fetcher
    }
    
}
