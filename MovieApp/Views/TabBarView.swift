//
//  TabBarView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 14.07.23.
//

import SwiftUI

struct TabBarView: View {
    private let service: APIService
    init(service: APIService) {
        self.service = service
    }
    var body: some View {
        TabView {
            MovieListView(service: service)
                .tabItem {
                    Label("Movies", systemImage: "")
                }
            
            MovieSearchView(service: service)
                .tabItem {
                    Label("Search", systemImage: "")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static let service = APIService()
    static var previews: some View {
        TabBarView(service: service)
    }
}
