//
//  MovieListView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

enum EndPoint: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case nowShowing = "now_showing"
    case popular
    case topRated = "top_rated"
    case upcoming
}

struct MovieListView: View {
    @State private var selectedCategory: Category = .nowShowing
    
    let categories = ["Now Showing", "Popular", "Top Rated", "Upcoming"]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var currentCategoryMovies: [Movie] {
        switch selectedCategory {
        case .nowShowing:
            return nowPlayingMoviesFetcher.nowPlayingMovies
        case .popular:
            return popularMoviesFetcher.popularMovies
        case .topRated:
            return topRatedMoviesFetcher.topRatedMovies
        case .upcoming:
            return upcomingMoviesFetcher.upcomingMovies
        }
    }
    
    @StateObject var nowPlayingMoviesFetcher: NowPlayingMoviesFetcher
    @StateObject var popularMoviesFetcher: PopularMoviesFetcher
    @StateObject var topRatedMoviesFetcher: TopRatedFetcher
    @StateObject var upcomingMoviesFetcher: UpcomingMoviesFetcher
    
    init(service: APIService) {
        _nowPlayingMoviesFetcher = StateObject(wrappedValue: NowPlayingMoviesFetcher(service: service))
        _popularMoviesFetcher = StateObject(wrappedValue: PopularMoviesFetcher(service: service))
        _topRatedMoviesFetcher = StateObject(wrappedValue: TopRatedFetcher(service: service))
        _upcomingMoviesFetcher = StateObject(wrappedValue: UpcomingMoviesFetcher(service: service))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Section {
                            ScrollView(.horizontal) {
                                HStack(spacing: 30) {
                                    ForEach(popularMoviesFetcher.popularMovies) { movie in
                                        NavigationLink {
                                            MovieDetailView(movie: movie, service: APIService())
                                        } label: {
                                            PosterImageView(movie: movie, width: 170, height: 300)
                                        }
                                    }
                                    .padding(.leading)
                                }
                            }
                        }
                        .padding(.bottom, 30)
                        
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(Category.allCases) { category in
                                        Button {
                                            selectedCategory = category
                                        } label: {
                                            Text(category.rawValue)
                                                .fontWeight(.semibold)
                                                .padding()
                                                .underline(selectedCategory == category)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                
                                        }
                                        .frame(width: 150)
                                    }
                                    .frame(width: 120)
                                    .padding(.leading)
                                }
                            }
                        }
                        
                        Section {
                            LazyVGrid(columns: columns) {
                                ForEach(currentCategoryMovies) { movie in
                                    NavigationLink {
                                        MovieDetailView(movie: movie, service: APIService())
                                    } label: {
                                        PosterImageView(movie: movie, width: 115, height: 200)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("What do you want to watch ?")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static let service = APIService()
    static var previews: some View {
        MovieListView(service: service)
    }
}
