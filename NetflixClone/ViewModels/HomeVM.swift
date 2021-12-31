//
//  HomeVM.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

final class HomeVM {
	
	private(set) var trendingMovies: [Title] = []
	private(set) var trendingTVs: [Title] = []
	private(set) var popularMovies: [Title] = []
	private(set) var upcomingMovies: [Title] = []
	private(set) var topRatedMovies: [Title] = []
	private(set) var discoverMovies: [Title] = []
	
	enum Section: Int, CaseIterable {
		
		case trendingMovies = 0, trendingTVs, popular, upcoming, topRated
		
		var title: String {
			
			switch self {
				case .trendingMovies: return "Trending Movies"
				case .trendingTVs: return "Trending TV Shows"
				case .popular: return "Popular"
				case .upcoming: return "Upcoming Movies"
				case .topRated: return "Top Rated"
			}
		}
	}
	
	func getTrendingMovies(completion: @escaping () -> Void) {
		
		APICaller.shared.getTrendingMovies { [weak self] result in
			
			guard let this = self else { return }
			
			switch result {
					
				case .success(let movies):
					this.trendingMovies = movies
					completion()
					
				case .failure(let error):
					print(error.localizedDescription)
					completion()
			}
		}
	}
	
	func getTrendingTVShows(completion: @escaping () -> Void) {
		
		APICaller.shared.getTrendingTVs { [weak self] result in
			
			guard let this = self else { return }
			
			switch result {
					
				case .success(let tvs):
					this.trendingTVs = tvs
					completion()
					
				case .failure(let error):
					print(error.localizedDescription)
					completion()
			}
		}
	}
	
	func getUpcomingMovies(completion: @escaping () -> Void) {
		
		APICaller.shared.getUpcomingMovies { [weak self] result in
			
			guard let this = self else { return }
			
			switch result {
					
				case .success(let movies):
					this.upcomingMovies = movies
					completion()
					
				case .failure(let error):
					print(error.localizedDescription)
					completion()
			}
		}
	}
	
	func getPopularMovies(completion: @escaping () -> Void) {
		
		APICaller.shared.getPopularMovies { [weak self] result in
			
			guard let this = self else { return }
			
			switch result {
					
				case .success(let movies):
					this.popularMovies = movies
					completion()
					
				case .failure(let error):
					print(error.localizedDescription)
					completion()
			}
		}
	}
	
	func getTopRatedMovies(completion: @escaping () -> Void) {
		
		APICaller.shared.getTopRatedMovies { [weak self] result in
			
			guard let this = self else { return }
			
			switch result {
					
				case .success(let movies):
					this.topRatedMovies = movies
					completion()
					
				case .failure(let error):
					print(error.localizedDescription)
					completion()
			}
		}
	}
	
	func getDiscoverMovies(completion: @escaping () -> Void) {
		
		APICaller.shared.getDiscoverMovies { [weak self] result in
			
			guard let this = self else { return }
			
			switch result {
					
				case .success(let movies):
					this.discoverMovies = movies
					completion()
					
				case .failure(let error):
					print(error.localizedDescription)
					completion()
			}
		}
	}
}
