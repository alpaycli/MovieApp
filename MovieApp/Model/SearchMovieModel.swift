//
//  SearchMovieModel.swift
//  MovieApp
//
//  Created by Alpay Calalli on 26.10.23.
//

import Foundation

/*
 {
    "adult": false,
    "backdrop_path": "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg",
    "genre_ids": [
        18,
        36
    ],
    "id": 872585,
    "original_language": "en",
    "original_title": "Oppenheimer",
    "overview": "The story of J. Robert Oppenheimer’s role in the development of the atomic bomb during World War II.",
    "popularity": 341.216,
    "poster_path": "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
    "release_date": "2023-07-19",
    "title": "Oppenheimer",
    "video": false,
    "vote_average": 8.248,
    "vote_count": 3956
}
 */


struct SearchMovieResponse: Codable {
    let results: [SearchMovie]
}

struct SearchMovie: Codable, Identifiable {
    let id: Int
    let originalTitle: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String
    
  
    
    static let example = SearchMovie(id: 0, originalTitle: "", releaseDate: "", voteAverage: 0.0, posterPath: "")
}
