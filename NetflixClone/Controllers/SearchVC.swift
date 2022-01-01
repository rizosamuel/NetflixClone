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

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		title = "Search"
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		
		view.addSubview(discoverTable)
		
		discoverTable.dataSource = self
		discoverTable.delegate = self
		
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
