//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Alpay Calalli on 01.07.23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: ResultMovie
    @StateObject var genreFetcher = GenreFetcher()
    @StateObject var moreMoviesFetcher: MoreMoviesFetcher
    init(movie: ResultMovie) {
        self.movie = movie
        _moreMoviesFetcher = StateObject(wrappedValue: MoreMoviesFetcher(movieId: movie.id))
    }
    var moreMovies: [ResultMovie] {
        moreMoviesFetcher.moreMovies
    }
    
    var allGenres: [String] {
        var items = [String]()
        for i in movie.genreIds {
            let item = genreFetcher.allGenres.filter { $0.id == i }.map { $0.name }
            items.append(item.joined())
        }
        return items
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                ScrollView {
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
                            Text(movie.originalTitle)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.top, 40)
                                .frame(maxWidth: .infinity)
                                .font(.title)
                        }
                        
                        Section {
                            HStack {
                                ForEach(allGenres, id: \.self) { genre in
                                    Text(genre)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(.white.opacity(0.85))
                                        .foregroundColor(.primary)
                                        .cornerRadius(10)
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
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
                            .padding(.vertical)
                        }
                        
                        Section {
                            VStack(alignment: .leading) {
                                Text("Overview")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.white)
                                
                                
                                Text(movie.overview)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        }
                        
                        if !moreMovies.isEmpty {
                            Section {
                                VStack(alignment: .leading) {
                                    Text("More like this")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundColor(.white)
                                    
                                    ScrollView(.horizontal) {
                                        HStack(spacing: 15) {
                                            ForEach(moreMovies) { movie in
                                                NavigationLink {
                                                    MovieDetailView(movie: movie)
                                                } label: {
                                                    PosterImageView(movie: movie, width: 115, height: 200)
                                                }
                                            }
                                        }
                                    }
                                    .scrollIndicators(.hidden)
                                }
                                .padding(.leading, 10)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .background(Color.backgroundColor)
                }
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: ResultMovie.exampleResult()[0])
    }
}
