//
//  MovieSearchView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 14.07.23.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModel = MovieSearchViewModel()
    
    private let popularMovies = [
        "Oppenheimer",
        "Barbie",
        "128 Hours",
        "Green Book",
        "The Irishman",
        "The Tinder Swindler"
    ]
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                if viewModel.searchText.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        Text("Popular searches")
                        ForEach(popularMovies, id: \.self) { item in
                            Button(item) { viewModel.searchText = item }
                        }
                    }
                } else if viewModel.searchResults.isEmpty {
                    Text("No movies found...")
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            ForEach(viewModel.searchResults) { movie in
                                NavigationLink {
                                    //      MovieDetailView(movie: movie)
                                } label: {
                                    SearchItemView(movie: movie)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchText, prompt: "Search movies")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
