//
//  PopularMoviesFetcher.swift
//  MovieApp
//
//  Created by Alpay Calalli on 16.07.23.
//

import Foundation

enum MovieCategory: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case nowShowing = "now_playing"
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    
    var displayTitle: String {
        switch self {
        case .nowShowing:
            "Now Showing"
        case .popular:
            "Popular"
        case .topRated:
            "Top Rated"
        case .upcoming:
            "Upcoming"
        }
    }
}

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var nowShowingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    let service: MoviesDataService
    
    init(service: MoviesDataService) {
        self.service = service
        Task {
            print("burda")
            await fetchPopularMovies()
        }
    }
    
    private func fetchPopularMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            nowShowingMovies = try await service.getMovies(type: .nowShowing)
            popularMovies = try await service.getMovies(type: .popular)
            topRatedMovies = try await service.getMovies(type: .topRated)
            upcomingMovies = try await service.getMovies(type: .upcoming)
            print("salam")
            isLoading = false
            
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }
    
}
