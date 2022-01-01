//
//  ViewController.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class MainTabVC: UITabBarController {

	override func viewDidLoad() {
		
		super.viewDidLoad()
		view.backgroundColor = .systemYellow
		
		let vc1 = UINavigationController(rootViewController: HomeVC())
		let vc2 = UINavigationController(rootViewController: UpcomingVC())
		let vc3 = UINavigationController(rootViewController: SearchVC())
		let vc4 = UINavigationController(rootViewController: DownloadVC())
		
		vc1.tabBarItem.image = UIImage(systemName: "house")
		vc2.tabBarItem.image = UIImage(systemName: "play.circle")
		vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
		vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
		
		vc1.title = "Home"
		vc2.title = "Coming Soon"
		vc3.title = "Top Searches"
		vc4.title = "Downloads"
		
		setViewControllers([vc1, vc2, vc3, vc4], animated: true)
		tabBar.tintColor = .label
	}
}
