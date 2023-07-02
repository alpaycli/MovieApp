//
//  GenreFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 02.07.23.
//

import Foundation

class GenreFetcher: ObservableObject {
    let const = Const()
    
    @Published var allGenres: [ResultGenre] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        
        isLoading = true
        errorMessage = nil
        let headers = [
            "Authorization": const.auth,
            "accept": const.accept
        ]
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en")!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        let service = APIService()
        
        service.fetch(Genre.self, url: urlRequest) { result in
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let genre):
                    print("--- sucess with \(genre.genres.count)")
                    self.allGenres = genre.genres
                }
            }
            
        }
        
    }
}