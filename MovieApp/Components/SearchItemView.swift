//
//  SearchItemView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 14.07.23.
//

import SwiftUI

struct SearchItemView: View {
    let movie: Movie
    var body: some View {
        HStack {
            PosterImageView(movie: movie, width: 95, height: 120)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.originalTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 15)
                    .lineLimit(1)
                
                
                Text("⭐ \(movie.voteAverage, specifier: "%.1f")")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                Text(movie.releaseDate
                    .map { String($0) }[...3].joined())
                .foregroundColor(Color.lightGrey)
                    .fontWeight(.bold)
                
                Text("duration")
                    .foregroundColor(Color.lightGrey)
                    .redacted(reason: .placeholder)
                
            }
            
            Spacer()
        }
        
        .background(Color.backgroundColor)
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(movie: Movie.exampleResult()[0])
    }
}
