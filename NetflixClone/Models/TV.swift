//
//  TV.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import Foundation

struct TrendingTVResponse: Codable {
	let results: [TV]
}

struct TV: Codable {
	
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
