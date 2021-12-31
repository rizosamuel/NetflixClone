//
//  Movie.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

struct TrendingTitleResponse: Codable {
	let results: [Title]
}

struct Title: Codable {
	
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
