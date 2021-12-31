//
//  UpcomingVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class UpcomingVC: UIViewController {
	
	private let homeVM = HomeVM()
	
	private let upcomingTable: UITableView = {
		
		let table = UITableView()
		table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
		return table
	}()

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		title = "Upcoming"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		
		view.addSubview(upcomingTable)
		upcomingTable.dataSource = self
		upcomingTable.delegate = self
		
		homeVM.getUpcomingMovies { DispatchQueue.main.async { self.upcomingTable.reloadData() } }
    }
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		upcomingTable.frame = view.bounds
	}
}

// MARK: - Table View Delegate Methods
extension UpcomingVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return homeVM.upcomingMovies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
		
		let titleName = homeVM.upcomingMovies[indexPath.row].originalTitle ?? "N/A"
		let posterUrl = homeVM.upcomingMovies[indexPath.row].posterPath ?? ""
		cell.configure(with: TitleVM(titleName: titleName, posterUrl: posterUrl))
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 90
	}
}
