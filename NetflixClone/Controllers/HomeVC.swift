//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class HomeVC: UIViewController {
	
	private let homeFeedTable: UITableView = {
		
		let table = UITableView()
		table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		return table
	}()

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		view.addSubview(homeFeedTable)
		
		homeFeedTable.dataSource = self
		homeFeedTable.delegate = self
    }
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		homeFeedTable.frame = view.bounds
	}
}

// MARK: - Table View Delegate Methods
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = "Hello World!"
		cell.backgroundColor = .red
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
}
