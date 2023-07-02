//
//  NowPlaying.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import Foundation

struct Movie: Codable {
    let results: [ResultMovie]
}

struct ResultMovie: Codable, Identifiable {
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let backdropPath: String
    let posterPath: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
    }
    
    init(id: Int, originalLanguage: String, originalTitle: String, overview: String, releaseDate: String, voteAverage: Double, backdropPath: String, posterPath: String) {
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.backdropPath = backdropPath
        self.posterPath = posterPath
    }
    
    static func exampleResult() -> [ResultMovie] {
        return [
            ResultMovie(id: 1, originalLanguage: "en", originalTitle: "Fast X", overview: "Vin Diesel drives car", releaseDate: "2023-05-17", voteAverage: 7.3, backdropPath: "/e2Jd0sYMCe6qvMbswGQbM0Mzxt0.jpg", posterPath: "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg"),
            ResultMovie(id: 4, originalLanguage: "ajsdj", originalTitle: "sajdja", overview: "jsdja", releaseDate: "ajsdaj", voteAverage: 4.4, backdropPath: "asda", posterPath: "")
        ]
    }
}
