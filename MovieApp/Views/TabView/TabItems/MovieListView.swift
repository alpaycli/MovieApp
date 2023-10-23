//
//  MovieListView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

struct MovieListView: View {
    @State private var movies: [Movie] = []
    @State private var selectedCategory: MovieCategory = .nowShowing
    
    private let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @StateObject private var viewModel: MovieListViewModel
    
    init(service: MoviesDataService) {
        self._viewModel = StateObject(wrappedValue: MovieListViewModel(service: service))
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
                                    ForEach(viewModel.popularMovies) { movie in
                                        NavigationLink {
                                        //    MovieDetailView(movie: movie, service: APIService())
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
                                    ForEach(MovieCategory.allCases) { category in
                                        Button {
                                            selectedCategory = category
                                            switch selectedCategory {
                                            case .nowShowing:
                                                movies = viewModel.nowShowingMovies
                                            case .popular:
                                                movies = viewModel.popularMovies
                                            case .topRated:
                                                movies = viewModel.topRatedMovies
                                            case .upcoming:
                                                movies = viewModel.upcomingMovies
                                            }
                                        } label: {
                                            Text(category.displayTitle)
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
                                ForEach(movies) { movie in
                                    NavigationLink {
                                      //  MovieDetailView(movie: movie, service: APIService())
                                    } label: {
                                        PosterImageView(movie: movie, width: 115, height: 200)
                                    }
                                }
                            }
                            
                            EmptyView()
                                .onAppear {
                                    print("Next Page")
                                }
                        }
                    }
                }
            }
            .onAppear {
                movies = viewModel.nowShowingMovies
            }
            .navigationTitle("Watch")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static let service = MoviesDataService()
    static var previews: some View {
        MovieListView(service: service)
    }
}
