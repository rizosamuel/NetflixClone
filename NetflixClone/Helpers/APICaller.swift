//
//  APICaller.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import Foundation

struct Constants {
	
	static let baseURL = "https://api.themoviedb.org"
	static let APIKey = "82ba938fe4f005f29458299dcb594fe2"
	static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
	static let gooleAPIKey = "AIzaSyCeSTWUxZKip7tIg4XUOYCVDWdugfpq3vo"
	static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
	case failedToGetData
}

final class APICaller {
	
	static let shared = APICaller()
	
	private init() { }
	
	func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
		
		let urlString = Constants.baseURL + "/3/trending/all/day?api_key=" + Constants.APIKey
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func getTrendingTVs(completion: @escaping (Result<[Title], Error>) -> Void) {
		
		let urlString = Constants.baseURL + "/3/trending/tv/day?api_key=" + Constants.APIKey
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
		
		let urlString = Constants.baseURL + "/3/movie/upcoming?api_key=" + Constants.APIKey + "&language=en-US&page=1"
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
		
		let urlString = Constants.baseURL + "/3/movie/popular?api_key=" + Constants.APIKey + "&language=en-US&page=1"
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
		
		let urlString = Constants.baseURL + "/3/movie/top_rated?api_key=" + Constants.APIKey + "&language=en-US&page=1"
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
		
		let urlString = Constants.baseURL + "/3/discover/movie?api_key=" + Constants.APIKey + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
		
		guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
		
		let urlString = Constants.baseURL + "/3/search/movie?api_key=" + Constants.APIKey + "&query=\(query)"
		print("search url is: ", urlString)
		
		guard let url = URL(string: urlString) else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(TrendingTitleResponse.self, from: data)
				completion(.success(results.results))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func getMovie(with query: String, completion: @escaping (Result<[VideoElement], Error>) -> Void) {
		
		guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
		
		guard let url = URL(string: "\(Constants.youtubeBaseUrl)q=\(query)&key=\(Constants.gooleAPIKey)") else { return }
		
		let urlRequest = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			
			guard let data = data, error == nil else { return }
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let results = try decoder.decode(YoutubeSearchResults.self, from: data)
				completion(.success(results.items))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
}
