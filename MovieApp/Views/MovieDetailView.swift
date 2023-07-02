//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: ResultMovie
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    ZStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.backdropPath)")!) { image in
                            image.resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text("⭐ \(movie.voteAverage, specifier: "%.1f")")
                            .frame(width: 54, height: 24)
                            .background(.black.opacity(0.85))
                            .cornerRadius(10)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .offset(x: 170, y: 90)
                            .foregroundColor(.orange)
                        
                    }
                }
                
                Section {
                    HStack {
                        PosterImageView(movie: movie, width: 95, height: 120)
                            
                        Text(movie.originalTitle)
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 40)
                    }
                    .offset(x: -90, y: -55)
                }
                
                Section {
                    HStack(spacing: 20) {
                        Group {
                            Text(movie.releaseDate.map { String($0) }[...3].joined())
                            
                            Text("|")
                            
                            Text(movie.originalLanguage.uppercased())
                            
                            Text("|")
                            
                            Text("Category")
                                .redacted(reason: .placeholder)
                        }
                        .foregroundColor(Color.lightGrey)
                    }
                }
                
                
                
                
                Spacer()
                
            }
            .background(Color.backgroundColor)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: ResultMovie.exampleResult()[0])
    }
}
