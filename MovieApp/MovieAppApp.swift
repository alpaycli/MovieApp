//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

@main
struct MovieAppApp: App {
    @StateObject private var dataService = MoviesDataService()
    
    var body: some Scene {
        WindowGroup { 
            TabBarView(service: dataService)
        }
    }
}
