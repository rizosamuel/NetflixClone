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
		cell.configure(with: homeVM.upcomingMovies, index: indexPath.row)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 140
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		let title = homeVM.upcomingMovies[indexPath.row]
		
		guard let titleName = title.originalTitle ?? title.originalName else { return }
		
		APICaller.shared.getMovie(with: titleName) { result in
			
			switch result {
					
				case .success(let videoElement):
					DispatchQueue.main.async {
						let vc = TitlePreviewViewController()
						let overview = title.overview ?? ""
						vc.configure(with: TitlePreviewVM(title: titleName, youtubeView: videoElement.first!, titleOverview: overview))
						self.navigationController?.pushViewController(vc, animated: true)
					}
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}
