//
//  TabBarView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 14.07.23.
//

import SwiftUI

struct TabBarView: View {
    private let service: MoviesDataService
    init(service: MoviesDataService) {
        self.service = service
    }
    var body: some View {
        TabView {
            MovieListView(service: service)
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }
            
            MovieSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(service: MoviesDataService())
    }
}
