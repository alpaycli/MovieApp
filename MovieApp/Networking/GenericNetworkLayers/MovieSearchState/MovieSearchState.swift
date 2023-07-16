//
//  MovieSearchState.swift
//  MovieApp
//
//  Created by Alpay Calalli on 16.07.23.
//

import Foundation
import Combine

@MainActor
class MovieSearchState: ObservableObject {
    @Published var searchResults: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let const = Const()
    
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func search(text: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(const.apiKey)&language=en-US&page=1&include_adult=false&query=\(text)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!)
            
            do {
                isLoading = false
                errorMessage = nil
                let decodedItems = try await service.fetch(MovieResponse.self, url: urlRequest)
                searchResults = decodedItems.results
            } catch {
                errorMessage = error.localizedDescription
                throw APIError.parsing(error as? DecodingError)
            }
            
        }
    }
    
}
