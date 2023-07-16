//
//  MovieSearchView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 14.07.23.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var searchState: MovieSearchState
    @State private var searchText = ""
    
    init(service: APIService) {
        _searchState = StateObject(wrappedValue: MovieSearchState(service: service))
    }
   
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(searchState.searchResults) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie, service: APIService())
                            } label: {
                                SearchItemView(movie: movie)
                            }
                        }
                    }
                }
                .navigationTitle("Search")
                .searchable(text: $searchText, prompt: "Search movies")
                .onChange(of: searchText) { newValue in
                    searchState.search(text: newValue.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            }
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static let service = APIService()
    static var previews: some View {
        MovieSearchView(service: service)
    }
}
