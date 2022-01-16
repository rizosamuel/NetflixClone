//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 09/01/22.
//

struct YoutubeSearchResults: Codable {
	
	let items: [VideoElement]
}

struct VideoElement: Codable {
	
	let id: VideoId
}

struct VideoId: Codable {
	
	let kind: String
	let videoId: String
}
