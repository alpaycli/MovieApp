//
//  ItemView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

struct PosterImageView: View {
    let movie: ResultMovie
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")!) { image in
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

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(movie: ResultMovie.exampleResult()[0], width: 115, height: 200)
    }
}
