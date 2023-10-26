//
//  MovieSearchState.swift
//  MovieApp
//
//  Created by Alpay Calalli on 16.07.23.
//

import Combine
import Foundation

@MainActor
final class MovieSearchViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var searchResults: [SearchMovie] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = MovieSearchDataService()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: loadResult)
            .store(in: &cancellables)
    }
    
    private func loadResult(searchText: String) {
        Task {
            let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            searchResults = try await dataService.getMovies(searchText: text)
            print(searchResults.count)
        }
    }
}



