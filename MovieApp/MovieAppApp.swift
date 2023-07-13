//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

@main
struct MovieAppApp: App {
    static let services = APIService()
    var body: some Scene {
        WindowGroup { 
            MovieListView(service: MovieAppApp.services)
        }
    }
}
