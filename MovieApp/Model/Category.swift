//
//  Category.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
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
