//
//  NowPlaying.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let backdropPath: String
    let posterPath: String
    
    let genreIds: [Int]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
    }
    
    init(id: Int, originalLanguage: String, originalTitle: String, title: String, overview: String, releaseDate: String, voteAverage: Double, backdropPath: String, posterPath: String, genreIds: [Int]) {
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.genreIds = genreIds
        self.title = title
    }
    
    static func exampleResult() -> [Movie] {
        return [
            Movie(id: 1, originalLanguage: "en", originalTitle: "Spider-man: far away from home", title: "Spider-man: far away from home", overview: "Vin Diesel drives car", releaseDate: "2023-05-17", voteAverage: 7.3, backdropPath: "/e2Jd0sYMCe6qvMbswGQbM0Mzxt0.jpg", posterPath: "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg", genreIds: [28, 12, 16]),
            Movie(id: 4, originalLanguage: "ajsdj", originalTitle: "sajdja", title: "sajdja", overview: "jsdja", releaseDate: "ajsdaj", voteAverage: 4.4, backdropPath: "asda", posterPath: "", genreIds: [28, 12, 35])
        ]
    }
}
