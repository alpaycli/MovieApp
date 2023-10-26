//
//  GenreFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 02.07.23.
//

import Foundation

class GenreFetcher: ObservableObject {
    @Published var allGenres: [ResultGenre] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchGenres()
    }
    
    private func fetchGenres() {
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": Const.auth,
            "accept": Const.accept
        ]
        
        Task {
            do {
                var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en")!)
                
                urlRequest.httpMethod = "GET"
                urlRequest.allHTTPHeaderFields = headers
                
                let genre: Genre = try await APIService.shared.fetch(Genre.self, url: urlRequest)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.allGenres = genre.genres
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
