//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class HomeVC: UIViewController {
	
	private let homeVM = HomeVM()
	
	private let homeFeedTable: UITableView = {
		
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
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
}

// MARK: - Table View Delegate Methods
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return HomeVM.Section.allCases.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as! CollectionViewTableViewCell
		
		switch indexPath.section {
				
			case HomeVM.Section.trendingMovies.rawValue:
				homeVM.getTrendingMovies { cell.configure(with: self.homeVM.trendingMovies) }
			case HomeVM.Section.trendingTVs.rawValue:
				homeVM.getTrendingTVShows { cell.configure(with: self.homeVM.trendingTVs) }
			case HomeVM.Section.popular.rawValue:
				homeVM.getPopularMovies { cell.configure(with: self.homeVM.popularMovies) }
			case HomeVM.Section.upcoming.rawValue:
				homeVM.getUpcomingMovies { cell.configure(with: self.homeVM.upcomingMovies) }
			case HomeVM.Section.topRated.rawValue:
				homeVM.getTopRatedMovies { cell.configure(with: self.homeVM.topRatedMovies) }
			default: break
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return HomeVM.Section.allCases[section].title
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		guard let header = view as? UITableViewHeaderFooterView else { return }
		
		header.contentView.backgroundColor = .systemBackground
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
