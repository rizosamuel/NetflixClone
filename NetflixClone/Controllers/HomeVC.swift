//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class HomeVC: UIViewController {
	
	private let sectionTitles: [String] = [
		"Trending Movies", "Trending TV Shows", "Popular", "Upcoming Movies", "Top Rated"
	]
	
	private let homeFeedTable: UITableView = {
		
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: "CollectionViewTableViewCell")
		return table
	}()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		view.addSubview(homeFeedTable)
		
		homeFeedTable.dataSource = self
		homeFeedTable.delegate = self
		
		let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
		homeFeedTable.tableHeaderView = headerView
		
		configureNavigationBar()
		// getTrendingMovies()
		// getTrendingTVShows()
		// getUpcomingMovies()
		// getPopularMovies()
		getTopRatedMovies()
	}
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		homeFeedTable.frame = view.bounds
	}
	
	private func configureNavigationBar() {
		
		let image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
		
		navigationItem.rightBarButtonItems = [
			UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
			UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
		]
		
		navigationController?.navigationBar.tintColor = .label
	}
	
	private func getTrendingMovies() {
		
		APICaller.shared.getTrendingMovies { result in
			
			switch result {
					
				case .success(let movies):
					print(movies)
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	private func getTrendingTVShows() {
		
		APICaller.shared.getTrendingTVs { result in
			
			switch result {
					
				case .success(let tvs):
					print(tvs)
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	private func getUpcomingMovies() {
		
		APICaller.shared.getUpcomingMovies { result in
			
			switch result {
					
				case .success(let tvs):
					print(tvs)
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	private func getPopularMovies() {
		
		APICaller.shared.getPopularMovies { result in
			
			switch result {
					
				case .success(let tvs):
					print(tvs)
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	private func getTopRatedMovies() {
		
		APICaller.shared.getTopRatedMovies { result in
			
			switch result {
					
				case .success(let tvs):
					print(tvs)
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}

// MARK: - Table View Delegate Methods
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sectionTitles.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as! CollectionViewTableViewCell
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionTitles[section]
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		guard let header = view as? UITableViewHeaderFooterView else { return }
		
		header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
		header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
		header.textLabel?.textColor = .label
		// header.textLabel?.text = header.textLabel?.text?.capitalized
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		let defaultOffset = view.safeAreaInsets.top
		let offset = scrollView.contentOffset.y + defaultOffset
		navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
	}
}
