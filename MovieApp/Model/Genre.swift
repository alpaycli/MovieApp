//
//  Genre.swift
//  MovieApp
//
//  Created by Alpay Calalli on 02.07.23.
//

import Foundation

struct Genre: Codable {
    let genres: [ResultGenre]
}

struct ResultGenre: Codable, Identifiable {
    let id: Int
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func exampleGenre() -> ResultGenre {
        ResultGenre(id: 12, name: "Adventure")
    }
    
}
