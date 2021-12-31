//
//  Movie.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

struct TrendingMoviesResponse: Codable {
	
	let results: [Movie]
	
}

struct Movie: Codable {
	
	let id: Int
	let mediaType: String?
	let originalName: String?
	let originalTitle: String?
	let posterPath: String?
	let overview: String?
	let voteCount: Int
	let releaseDate: String?
	let voteAverage: Double
}
