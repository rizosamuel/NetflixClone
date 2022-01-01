//
//  SearchVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class SearchVC: UIViewController {
	
	private let homeVM = HomeVM()
	
	private let discoverTable: UITableView = {
		
		let table = UITableView()
		table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
		return table
	}()
	
	private let searchController: UISearchController = {
		
		let controller = UISearchController(searchResultsController: SearchResultsVC())
		controller.searchBar.placeholder = "Search for a Movie or TV Show"
		controller.searchBar.searchBarStyle = .minimal
		return controller
	}()

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		title = "Search"
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		navigationItem.searchController = searchController
		navigationController?.navigationBar.tintColor = .label
		
		view.addSubview(discoverTable)
		
		discoverTable.dataSource = self
		discoverTable.delegate = self
		
		searchController.searchResultsUpdater = self
		
		homeVM.getDiscoverMovies { DispatchQueue.main.async { self.discoverTable.reloadData() } }
    }
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		discoverTable.frame = view.bounds
	}
}

// MARK: - Table View Delegate Methods
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return homeVM.discoverMovies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
		cell.configure(with: homeVM.discoverMovies, index: indexPath.row)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 140
	}
}

// MARK: - Search Controller Methods
extension SearchVC: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		
		let searchBar = searchController.searchBar
		
		guard let query = searchBar.text,
				!query.trimmingCharacters(in: .whitespaces).isEmpty,
			  query.trimmingCharacters(in: .whitespaces).count >= 3,
			  let resultsController = searchController.searchResultsController as? SearchResultsVC else {
				  
				  return
			  }
		
		APICaller.shared.search(with: query) { result in
			
			switch result {
					
				case .success(let titles):
					resultsController.titles = titles
					DispatchQueue.main.async {
						resultsController.searchResultsCollectionView.reloadData()
					}
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}
