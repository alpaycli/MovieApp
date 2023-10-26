//
//  ItemView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

struct PosterImageView: View {
    let movie: Movie?
    let searchMovie: SearchMovie?
    let width: CGFloat
    let height: CGFloat
    
    init(movie: Movie, width: CGFloat, height: CGFloat, searchMovie: SearchMovie? = nil) {
        self.width = width
        self.height = height
        
        self.movie = movie
        self.searchMovie = searchMovie
    }
    
    init(searchMovie: SearchMovie, width: CGFloat, height: CGFloat, movie: Movie? = nil) {
        self.width = width
        self.height = height
        
        self.searchMovie = searchMovie
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            if let movie {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .cornerRadius(40)
                } placeholder: {
                    ProgressView()
                }
            } else if let searchMovie {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(searchMovie.posterPath)")) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .cornerRadius(40)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(movie: Movie.exampleResult()[0], width: 115, height: 200)
    }
}
